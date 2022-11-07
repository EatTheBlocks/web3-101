// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

contract WEB3101 is ERC777 {
    /* We need to set the defaultOperators: special accounts(usually other smart contacts) 
    that will be able to transfer tokens on behalf of their holders. If you’re not planning 
    on using operators in your token, you can simply pass an empty array.
    */
    constructor(uint256 initialSupply, address[] memory defaultOperators)
        ERC777("Web3 101", "WEB3101", defaultOperators)
    {
        _mint(msg.sender, initialSupply, "", "");
    }
}
