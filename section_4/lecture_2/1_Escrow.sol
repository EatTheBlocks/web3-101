// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Escrow{
  address public buyer; // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
  address payable public seller; // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
  address public escrowParty; // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
  // Can use https://eth-converter.com/ to convert ether to wei
  uint public amount; // 1000000000000000000 WEI = 1 ETH
  
  // The escrow party deploys the contract with the buyer and seller info 
  // along with the amount of Ether needed to purchase the item
  constructor(address _buyer, address payable _seller, uint _amount) {
    buyer = _buyer;
    seller = _seller;
    escrowParty = msg.sender; 
    amount = _amount;
  }

  // This is the function the buyer sends the money to
  // We ensure that the buyer doesn't send more money than what is required
  function deposit() payable public {
    require(msg.sender == buyer, 'Sender must be the buyer of the item');
    require(address(this).balance <= amount, 'Cannot send more than the amount required by the escrow');
  }

  // This is the function the escrow party will call to send the money 
  // to the seller
  function release() public onlyEscrowParty() {
    require(address(this).balance == amount, 'Cannot release funds before full amount is sent');
    seller.transfer(amount);
  }
  
  function balanceOf() view public returns(uint) {
    return address(this).balance;
  }

  modifier onlyEscrowParty() {
      require(msg.sender == escrowParty, 'Only escrow party can perform this operation');
      _;
  }
}