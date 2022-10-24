// SPDX-License-Identifier: MIT
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
