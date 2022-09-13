// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
  uint storedData; // State variable

  function calculation(uint x, uint y) public returns(uint) {
    uint result = x * (x + y);
    storedData = result;
    return result;
  }
}