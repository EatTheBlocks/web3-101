// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WEB3101 is ERC20 {
    constructor(uint256 initialSupply) ERC20("Web3 101", "WEB3") {
        _mint(msg.sender, initialSupply);
    }
}
