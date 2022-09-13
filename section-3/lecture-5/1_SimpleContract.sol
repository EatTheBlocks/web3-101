// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract SimpleContract {
    uint storedData; // State variable

    function getStoredData() public view returns(uint) {
        return storedData;
    }
}

function square(uint x) pure returns(uint) {
    return x * x;
}