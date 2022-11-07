// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract WEB3101Ownable1 is Ownable {
    function normalThing() public {
        // anyone can call this normalThing()
    }

    function specialThing() public onlyOwner {
        // only the owner can call specialThing()!
    }
}

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WEB3101Ownable2 is ERC20, Ownable {
    constructor() ERC20("Web3 101", "WEB3") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
