// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

contract Wallet {
    // Gonna let one person(the deployer) able to send and withdraw from the wallet
    // Single person Ether wallet
    // Implement the "deposit()" and "withdraw()" function
    // Implement the "balanceOf" to retrieve the current balance in the wallet

    address payable public owner;

    constructor() {
        owner = payable(tx.origin);
    }

    function deposit() public payable {}

    function withdraw(address payable receiver, uint amount) public onlyOwner {
        receiver.transfer(amount);
    }

    function balanceOf() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {}

    modifier onlyOwner() {
        require(tx.origin == owner, "Not an owner of the wallet");
        _;
    }
}
