// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

error Unauthorized();
/// Insufficient balance for transfer. Needed `required` but only
/// `available` available.
/// @param available balance available.
/// @param required requested amount to transfer.
error InsufficientBalance(uint256 available, uint256 required);

contract CustomErrorContract {
    mapping(address => uint256) private wallets;

    function deposit() public payable {
        wallets[msg.sender] += msg.value;
    }

    function withdraw(address payable receiver, uint amount) public {
        // require(msg.sender == receiver, "Only owner can withdraw from the wallet");
        if (msg.sender != receiver) {
            revert Unauthorized();
        }
        // require(wallets[msg.sender] >= amount, "Not enough money in the wallet");
        if (amount > wallets[msg.sender])
            // Error call using named parameters. Equivalent to
            // revert InsufficientBalance(balance[msg.sender], amount);
            revert InsufficientBalance({
                available: wallets[msg.sender],
                required: amount
            });
        wallets[msg.sender] -= amount;
        receiver.transfer(amount);
    }

    function myBalance() public view returns (uint) {
        return wallets[msg.sender];
    }
}
