// SPDX-License-Identifier: MIT
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
