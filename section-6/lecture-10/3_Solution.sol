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

contract Solution {
    parent parentInstance;

    constructor(address _parent_address) {
        parentInstance = parent(_parent_address);
    }
    
    function getParentValue() public view returns(uint){  
        return parentInstance.getValue();
    }  
    
    function setParentValue(uint _child_value) public {
        parentInstance.setValue(_child_value);
    }  
}
