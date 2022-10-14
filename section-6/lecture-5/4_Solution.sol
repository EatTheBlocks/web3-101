// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract SayHello {
    uint256 public age;

    constructor(uint256 _age ){
        age = _age;
    }

    function setAge(uint256 _age) public virtual {}
    function makeMeSayHello() public  pure returns (string memory) 
    {
        return "Hello";
    }
}

contract Solution is SayHello {
    string public name;
    constructor(string memory _name  ,uint256  _age) SayHello(_age) {
       name = _name;
    }

    function setName(string memory _name ) public {
        name = _name;
    }

    function setAge(uint256 _age ) public override virtual {
        age = _age;
    }
}