// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* Declare a custom error type which is called whenever the user tries to
   send ETH that is less than what's required
*/

// TODO: Create a custom error type called "InvalidAmount". Needed `minRequired` but sent `amount`

contract Exercise {
    mapping(address => uint) balances;
    uint minRequired;
    
    constructor (uint256 _minRequired) {
        minRequired = _minRequired;
    }
    
    function list() public payable {
        uint256 amount = msg.value;
        /* TODO: Check whether the amount being sent is less than the minimum required. If so, 
           call the custom error defined above and revert the transaction
        */
        balances[msg.sender] += amount;
    }
}