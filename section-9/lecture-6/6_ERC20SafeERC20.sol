// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract WEB3101SafeERC20 {
    using SafeERC20 for IERC20;

    IERC20 public _token;

    constructor(IERC20 token) {
        _token = token;
    }

    function increase(address spender, uint num) public {
        _token.safeIncreaseAllowance(spender, num);
    }

    function decrease(address spender, uint num) public {
        _token.safeDecreaseAllowance(spender, num);
    }
}
