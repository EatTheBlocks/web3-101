// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract WEB3101Capped is ERC20Capped {
    constructor(uint256 initialSupply)
        ERC20("Web3 101", "WEB3")
        ERC20Capped(initialSupply)
    {
        _mint(msg.sender, initialSupply);
    }
}
