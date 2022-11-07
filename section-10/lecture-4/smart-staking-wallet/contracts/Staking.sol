// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

import "./Wallet.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";

contract Staking is ERC20 {
    event WalletCreate(uint256 walletid, address _address);
    event WalletDeposit(uint256 walletid, uint256 amount);
    event StakeEth(uint256 walletid, uint256 amount, uint256 startTime);
    event UnStakeEth(uint256 walletid, uint256 amount, uint256 numStocksReward);
    event WalletWithdraw(uint256 walletid, address _to, uint256 amount);

    using EnumerableMap for EnumerableMap.UintToAddressMap;

    struct StakeWallet {
        Wallet user;
        uint256 stakedAmount;
        uint256 sinceBlock;
        uint256 untilBlock;
    }

    StakeWallet[] private stakeWallets;

    EnumerableMap.UintToAddressMap private walletsStaked;

    uint256 public constant percentPerBlock = 1; // Bonus Exercise: use more granular units

    constructor() ERC20("WEB3 101", "WEB3") {}

    function walletCreate()
        public
        returns (uint256 walletId, address _address)
    {
        Wallet wallet = new Wallet();
        stakeWallets.push(StakeWallet(wallet, 0, 0, 0));
        uint256 walletid = stakeWallets.length - 1;
        emit WalletCreate(walletId, address(wallet));
        return (walletid, address(wallet));
    }

    function getWallets() public view returns (StakeWallet[] memory) {
        return stakeWallets;
    }

    function walletDeposit(uint256 _walletId)
        public
        payable
        isWalletOwner(_walletId)
    {
        StakeWallet storage stakeWallet = stakeWallets[_walletId];
        stakeWallet.user.deposit{value: msg.value}();
        emit WalletDeposit(_walletId, msg.value);
    }

    function walletBalance(uint256 _walletId) public view returns (uint256) {
        StakeWallet memory stakeWallet = stakeWallets[_walletId];
        return stakeWallet.user.balanceOf();
    }

    function walletWithdraw(
        uint256 _walletId,
        address payable _to,
        uint _amount
    ) public payable isWalletOwner(_walletId) {
        StakeWallet storage stakeWallet = stakeWallets[_walletId];
        stakeWallet.user.withdraw(_to, _amount);
        emit WalletWithdraw(_walletId, _to, _amount);
    }

    // Bonus Exercise: Let user stake any amount of ETH rather than the whole balance
    function stakeEth(uint256 _walletId) public isWalletOwner(_walletId) {
        StakeWallet storage stakeWallet = stakeWallets[_walletId];
        uint256 currentBalance = stakeWallet.user.balanceOf();
        require(currentBalance > 0, "Wallet Balance needs to be non-zero");

        stakeWallet.user.withdraw(payable(address(this)), currentBalance);

        uint256 stakedForBlocks = (block.timestamp - stakeWallet.sinceBlock);
        uint256 totalUnclaimedRewards = (stakeWallet.stakedAmount *
            stakedForBlocks *
            percentPerBlock) / 100;
        _mint(msg.sender, totalUnclaimedRewards);

        stakeWallet.stakedAmount += currentBalance;
        stakeWallet.sinceBlock = block.timestamp;
        stakeWallet.untilBlock = 0;

        walletsStaked.set(_walletId, address(stakeWallet.user));

        emit StakeEth(_walletId, currentBalance, block.timestamp);
    }

    function currentStake(uint256 _walletId) public view returns (uint256) {
        StakeWallet memory stakeWallet = stakeWallets[_walletId];
        return stakeWallet.stakedAmount;
    }

    function currentReward(uint256 _walletId) public view returns (uint256) {
        StakeWallet memory stakeWallet = stakeWallets[_walletId];

        uint256 stakedForBlocks = (block.timestamp - stakeWallet.sinceBlock);
        uint256 totalUnclaimedRewards = (stakeWallet.stakedAmount *
            stakedForBlocks *
            percentPerBlock) / 100;

        return totalUnclaimedRewards;
    }

    function totalAddressesStaked() public view returns (uint256) {
        return walletsStaked.length();
    }

    function isWalletStaked(uint256 _walletId) public view returns (bool) {
        return walletsStaked.contains(_walletId);
    }

    function unstakeEth(uint256 _walletId)
        public
        payable
        isWalletOwner(_walletId)
    {
        StakeWallet storage stakeWallet = stakeWallets[_walletId];
        require(stakeWallet.untilBlock == 0, "Already unstaked");

        uint256 currentBalance = stakeWallet.stakedAmount;
        payable(address(stakeWallet.user)).transfer(currentBalance);

        uint256 rewardAmount = currentReward(_walletId);
        _mint(msg.sender, rewardAmount);

        stakeWallet.untilBlock = block.timestamp;
        stakeWallet.sinceBlock = 0;
        stakeWallet.stakedAmount = 0;

        walletsStaked.remove(_walletId);
        emit UnStakeEth(_walletId, stakeWallet.stakedAmount, rewardAmount);
    }

    receive() external payable {}

    modifier isWalletOwner(uint256 walletId) {
        require(msg.sender != address(0), "Invalid owner");
        StakeWallet memory stakeWallet = stakeWallets[walletId];
        require(
            msg.sender == stakeWallet.user.owner(),
            "Not the owner of the wallet"
        );
        _;
    }
}
