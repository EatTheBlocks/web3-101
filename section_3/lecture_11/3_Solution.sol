// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    uint public num;

    receive() external payable {
    }

    fallback() external payable {
        num = msg.value;
    }
}