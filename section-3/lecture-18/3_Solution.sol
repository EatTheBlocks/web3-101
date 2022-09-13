// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    uint amountRequired = 100;

    function buy() public payable {
        // Using require statement
        require(msg.value == amountRequired, "Amount not exact");
        // Using revert statement
        if(msg.value != amountRequired) {
          revert("Amount not exact");
        }
    }
}