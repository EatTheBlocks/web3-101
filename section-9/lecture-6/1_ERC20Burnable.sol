// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract WEB3101Burnable is ERC20, ERC20Burnable {
    constructor(uint256 initialSupply) ERC20("Web3 101", "WEB3") {
        _mint(msg.sender, initialSupply);
    }
}
