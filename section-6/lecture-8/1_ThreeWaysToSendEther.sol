// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SendEther {
    /*
   transfer: (2300 gas, throws error)
 
   the receiving smart contract should have a fallback function defined or
   else the transfer call will throw an error. There is a gas limit of 2300 gas,
   which is enough to complete the transfer operation. It is hardcoded to prevent
   reentrancy attacks.
   */
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    /*
   send: (2300 gas, throws error)
 
   It works in a similar way as to transfer call and has a gas limit of 2300 gas
   as well. It returns the status as a boolean.
   */
    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    /*
   call: (forward all gas or set gas, returns bool)
 
   It is the recommended way of sending ETH to a smart contract.
   The empty argument triggers the fallback function of the receiving address.
   */
    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");

        /*
       using call, one can also trigger other functions defined in the contract and
       send a fixed amount of gas to execute the function. The transaction status is
       sent as a boolean and the return value is sent in the data variable.
       */
        // (bool sent, bytes memory data) = _to.call{gas :10000, value: msg.value}("func_signature(uint256 args)");
        require(sent, "Failed to send Ether");
    }
}
