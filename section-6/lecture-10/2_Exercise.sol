// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract parent {  
    uint public num;
    
    function setValue(uint _value) public {  
        num = _value;  
    }
    
    function getValue() public view returns(uint) {  
        return num;  
    }  
}

/*
    Create a contract that calls the "parent" contract functions
*/
contract Exercise {
    // Creating an instance of the parent contract as a state variable
    parent parentInstance;

    // TODO: Call the parent contract constructor and set the parentInstance to that value
    constructor(address _parent_address) {
    }
    
    // TODO: Call the "getValue" function of the parent contract
    function getParentValue() public view returns(uint){  
    }  
    
    // TODO: Call the "setValue" function of the parent contract
    function setParentValue(uint _child_value) public {
    }  
}