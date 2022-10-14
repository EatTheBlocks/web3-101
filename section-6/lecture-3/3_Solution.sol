// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// Invalid balance to transfer. Needed `minRequired` but sent `amount`
/// @param sent sent amount.
/// @param minRequired minimum amount to send.
error InvalidAmount (uint256 sent, uint256 minRequired);

contract Solution {
    mapping(address => uint) balances;
    uint minRequired;
    
    constructor (uint256 _minRequired) {
        minRequired = _minRequired;
    }
    
    function list() public payable {
        uint256 amount = msg.value;
        if (amount < minRequired) {
            revert InvalidAmount({
                sent: amount,
                minRequired: minRequired
            });
        }
        balances[msg.sender] += amount;
    }
}
