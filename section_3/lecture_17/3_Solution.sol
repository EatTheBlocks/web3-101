// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    mapping (address => uint256) private balances;

    function transfer(address sender, address recipient, uint256 amount) internal {
        balances[sender] -= amount;
        balances[recipient] += amount;
    }
}