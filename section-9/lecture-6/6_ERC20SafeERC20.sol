// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
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
