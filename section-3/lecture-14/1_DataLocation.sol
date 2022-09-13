// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract DataLocation {
    uint public age;
    uint[] ages;

    constructor() {
        age = 30;
    }

    // The data location of age2 is memory;
    function changeAge() public returns(uint) {
        uint age2 = age; // assign storage -> memory creates copy
        age = 20;
        return age2; // returns 30
    }

    function f(uint[] memory memoryArray) public returns(uint[] memory, uint[] memory) {
        ages = memoryArray; // works, copies the whole array to the storage
        uint[] storage y = ages; // works, assigns a pointer(reference), data location
            // of y is storage
        ages[0] = 2;
        return (y, ages);
    }


}