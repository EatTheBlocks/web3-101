// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract ErrorContract {
    int public balance;
    int public constant MAX_UINT = 2**128 - 1;

    function deposit(int _amount) public {
        int oldBalance = balance;
        int newBalance = balance + _amount;

        // balance + _amount DOES NOT overflow 
        // if the balance + amount >= balance
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(int _amount) public {
        int oldBalance = balance;

        // balance - _amount does not underflow 
        // if balance >= _amount
        require(balance >= _amount, "Underflow");

        if(balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}