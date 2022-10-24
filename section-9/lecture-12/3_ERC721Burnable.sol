// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract WEB3101Burnable is ERC721, ERC721Burnable {
    constructor() ERC721("Web3 101", "WEB3") {}
}
