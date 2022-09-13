// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {

  function addition() public payable returns(uint) {
    // Get the block number
    uint blockNumber = block.number;
    // Get the Ether sent when calling this function
    uint etherSent = msg.value;
    // Add the two numbers together
    // Return the result
    return (blockNumber + etherSent);
  }
}