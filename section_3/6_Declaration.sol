// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Declaration {
    uint public a;
    bool public b;
    string public c;
    address public d;
    bytes32 public e;

    function variableScoping() public {
        a = 1;
        {
            a = 2;
            uint sameVar;
            sameVar = 1;
        }
        {
            uint sameVar;
            sameVar = 2;
        }
    }
}

