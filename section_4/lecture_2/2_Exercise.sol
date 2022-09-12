// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/*
Update the “Escrow” contract from the lecture in the following ways:
- The seller can be multiple people. You may need to keep track of this using an array
- The escrow party address can be changed to a different address at any point in the future with a new function called “changeEscrow” that should only able to be called if you’re an escrow party yourself
- Anyone should be able to deposit to the escrow and not just the buyer
- You should be able to send any amount of money to the escrow. It doesn’t need to be the exact amount
- You may also need to update the release function to account for the above new conditions
- Releasing the escrow funds will send Ether to the multiple sellers if any in equal ratio
*/
contract Exercise {
    address public buyer; // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // Todo: Keep track of the multiple sellers rather than a single seller  
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

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

    // Todo: Update the deposit function to handle the following changes
    // 1) deposit to the escrow account
    // 2) We can let anyone send some Ether to this account
    // 3) Should be able to send any amount of Ether

    
    // Todo: Update the release function to handle the following changes
    // 1) the escrow party will call this function to send the money to the sellers
    // 2) Releasing the escrow funds will send Ether to the multiple sellers if any in equal ratio
    function release() public onlyEscrowParty() {
    }
    
    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }

    // Todo: Create a new function to change the escrow party at any point in the future
    // function changeEscrow()

    modifier onlyEscrowParty() {
        require(msg.sender == escrowParty, 'Only escrow party can perform this operation');
        _;
    }
}