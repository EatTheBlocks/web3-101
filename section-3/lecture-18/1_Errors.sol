// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
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

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}
