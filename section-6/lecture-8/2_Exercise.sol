// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
    This is a contract that has a function called "foo" and fallback and receive
    functions. We'll be calling the function "foo" of this contract from our contract
    down below
*/
contract Receiver {
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    receive() external payable {
    }

    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

/*
    TODO: Create a functtion called "testCallFoo" whereby it takes the address of a smart contract as
    an argument(in our case, it would be the address of the above Receiver contract) and uses the
    "call" function to send ETH to the Receiver contract. The "call" function should also
    set the amount of gas to use and it should also call the function "foo" of the Receiver
    smart contract with the arguments ("call foo", 123)
*/
contract Exercise {
    event Response(bool success, bytes data);

    // Let's imagine that contract Caller does not have the source code for the
    // contract Receiver, but we do know the address of contract Receiver and the function to call.
    function testCallFoo(address payable _addr) public payable {
        // TODO: You can send ether and specify a custom gas amount

        emit Response(success, data);
    }
}