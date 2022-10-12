// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

contract Caller {
    function setX(Callee _callee, uint _x) public returns (uint) {
        uint x = _callee.setX(_x);
        return x;
    }

    function setXandSendEther(Callee _callee, uint _x)
        public
        payable
        returns (uint, uint)
    {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
        return (x, value);
    }
}
