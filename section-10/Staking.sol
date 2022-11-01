// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Wallet.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SmartWallet is ERC1155, ERC1155URIStorage {
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    
    struct Stake {
        Wallet wallet;
        mapping(uint256 => uint256) stakingPool;
        mapping(uint256 => uint256) stakingTime;
    }

    mapping(address => Stake) private stake;

    constructor() ERC1155("SHARE-") {
        _setBaseURI("SHARE-");
        _setURI(0, "0");
        _tokenIds.increment();
    }

    function walletCreate() public returns(address) {
        Wallet wallet = new Wallet();
        Stake storage _stake = stake[address(wallet)];
        _stake.wallet = wallet;
        return address(wallet);
    }

    function walletDeposit(address _address) public payable isOwner(_address) {
        Wallet wallet = stake[_address].wallet;
        wallet.deposit{value:msg.value}();
    }

    // TODO: Let user stake any amount of ETH rather than the whole balance
    function stakeEth(address _address) public isOwner(_address) {
        Wallet wallet = stake[_address].wallet;
        uint256 currentBalance = wallet.balanceOf();
        require(currentBalance > 0, "Wallet Balance needs to be non-zero");        
        wallet.withdraw(payable(address(this)), currentBalance);
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId, 1, "");      
        _setURI(newItemId, Strings.toString(newItemId));
        stake[_address].stakingPool[newItemId] = currentBalance;
        stake[_address].stakingTime[newItemId] = block.timestamp;
        _tokenIds.increment();
    }

    function stakeBalance(address _address, uint256 _tokenId) public view returns(uint256) {
        return stake[_address].stakingPool[_tokenId];
    }

    function unstakeEth(address _address, uint256 _tokenId) public payable isOwner(_address) {
        require(stake[_address].stakingPool[_tokenId] > 0, "Not staked");    
        Wallet wallet = stake[_address].wallet;
        payable(address(wallet)).transfer(stake[_address].stakingPool[_tokenId]);
        uint256 rewardAmount = stockBalance(_address, _tokenId);
        _burn(msg.sender, _tokenId, 1);
        delete stake[_address].stakingPool[_tokenId];
        _mint(msg.sender, 0, rewardAmount, ""); 
    }

    function walletWithdraw(address _address, address payable _to, uint _amount) public payable isOwner(_address) {
        Wallet wallet = stake[_address].wallet;
        wallet.withdraw(_to, _amount);
    }

    function walletBalance(address _address) public view returns(uint256) {
        Wallet wallet = stake[_address].wallet;
        return wallet.balanceOf();
    }

    function stockBalance(address _address, uint256 _tokenId) public view returns(uint256) {
        uint256 rewardAmount = 0;
        if(stake[_address].stakingPool[_tokenId] > 0) {
            uint256 secondsPassed = block.timestamp - stake[_address].stakingTime[_tokenId];
            rewardAmount = secondsPassed / 60;
        }       
        return rewardAmount;
    }

    function uri(uint256 tokenId) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        return super.uri(tokenId);
    }

    receive() external payable {}

    modifier isOwner(address _address) {
        require(msg.sender != address(0), "Invalid owner");
        Wallet wallet = stake[_address].wallet;
        require(msg.sender == wallet.owner(), "Not the owner of the wallet");
        _;
    }
}