// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Solution {
   event Deposit(address indexed _from, uint _value);
   
   function deposit() public payable {      
      emit Deposit(msg.sender, msg.value);
   }
}
