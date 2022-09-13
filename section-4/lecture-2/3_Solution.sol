// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    address public buyer; // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    address payable[] public sellers; 
    address public escrowParty; // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // Can use https://eth-converter.com/ to convert ether to wei
    uint public amount; // 1000000000000000000 WEI = 1 ETH
    
    // The escrow party deploys the contract with the buyer and seller info 
    // along with the amount of Ether needed to purchase the item
    constructor(address _buyer, address payable[] memory _sellers, uint _amount) {
        buyer = _buyer;
        sellers = _sellers;
        escrowParty = msg.sender; 
        amount = _amount;
    }

    // This is the function the to deposit to the escrow account
    // We can let anyone send some Ether to this account
    function deposit() payable public {
    }

    // This is the function the escrow party will call to send the money 
    // to the sellers equally
    function release() public onlyEscrowParty() {
        require(address(this).balance >= amount, 'Cannot release funds before at least enough money is sent');
        for(uint i = 0; i <= sellers.length - 1; i++) {
            sellers[i].transfer(amount/sellers.length);     
        }
    }
    
    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }

    function changeEscrow(address _newEscrowParty) public onlyEscrowParty() {
        escrowParty = _newEscrowParty;
    }

    modifier onlyEscrowParty() {
        require(msg.sender == escrowParty, 'Only escrow party can perform this operation');
        _;
    }
}