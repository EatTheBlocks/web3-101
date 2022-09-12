// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {

  modifier validAddress(address _addr) {
    require(_addr != address(0), "Not valid address");
    _;
  }
}