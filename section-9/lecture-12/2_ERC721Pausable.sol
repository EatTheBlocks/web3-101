// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";

contract WEB3101Pausable is ERC721Pausable {
    constructor() ERC721("Web3 101", "WEB3") {}

    // This is obviously dangerous as anyone can pause this smart contract
    // One solution may be to let only the owner be able to call this function
    function pause() public {
        _pause();
    }

    // This is obviously dangerous as anyone can unpause this smart contract
    // One solution may be to let only the owner be able to call this function
    function unpause() public {
        _unpause();
    }
}
