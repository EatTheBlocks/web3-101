// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library MathUtils {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}

contract Calculator {
    using MathUtils for uint;

    function getSum(uint firstNumber, uint secondNumber)
        public
        pure
        returns (uint)
    {
        // Invoke and return the library function here ...
        return firstNumber.add(secondNumber);
    }
}
