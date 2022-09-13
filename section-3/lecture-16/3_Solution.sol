// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

struct Wallet {
    address addr;
    uint amount;
}

contract Solution {

  struct CrowdFunding {
    address payable beneficiary;
    uint numFunders;
    Wallet[] wallets;
  }
}