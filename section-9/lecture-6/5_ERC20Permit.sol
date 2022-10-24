// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract WEB3101Permit is ERC20, ERC20Permit {
    constructor(uint256 initialSupply)
        ERC20("Web3 101", "WEB3")
        ERC20Permit("Web3 101")
    {
        _mint(msg.sender, initialSupply);
    }
}
