// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/

pragma solidity ^0.8.16;

contract Conditional {
    uint myValue = 10;

    function isLessThanOrEqual(uint testValue) public view returns (bool) {
        if (testValue <= myValue) {
            return true;
        } else {
            return false;
        }
    }
}

contract LoopsWhile {
    uint public myValue = 0;

    function incrementer() public {
        while (myValue <= 100) {
            myValue++;
        }
    }
}

contract LoopsFor {
    uint public myValue = 0;

    function incrementer() public {
        for (uint i = 0; i <= 100; i++) {
            myValue++;
        }
    }
}

contract LoopsBreak {
    uint public myValue = 0;

    function incrementer() public {
        for (uint i = 0; i < 100; i++) {
            myValue++;
            if (myValue == 5) {
                break;
            }
        }
    }
}

contract LoopsContinue {
    uint public myValueFor = 0;
    uint public myValueWhile = 0;

    function forIncrementer() public {
        for (uint i = 0; i < 5; i++) {
            if (i == 1) {
                continue;
            }
            myValueFor++;
        }
    }

    function whileIncrementer() public {
        uint i = 0;
        while (i < 5) {
            i++;
            if (i == 1) {
                continue;
            }
            myValueWhile++;
        }
    }
}

contract ReturnContract {
    uint public myValue = 0;

    function returnerWithNoValue() public {
        myValue = 1;
        return;
        // myValue = 2; // This will never execute
    }

    function returnerWithValue() public returns (uint) {
        myValue = 3;
        return myValue;
    }
}
