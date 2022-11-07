// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/

pragma solidity ^0.8.16;

contract BuiltInVarsAndFuncs {
    function genesisBlockHash() public view returns (bytes32) {
        return blockhash(0);
    }

    function blockBaseFee() public view returns (uint) {
        return block.difficulty;
    }

    function gasLimit() public view returns (uint) {
        return block.gaslimit;
    }

    function blockNumber() public view returns (uint) {
        return block.number;
    }

    function msgSender() public view returns (address) {
        return msg.sender;
    }

    function msgValue() public payable returns (uint) {
        return msg.value;
    }

    function txOrigin() public view returns (address) {
        return tx.origin;
    }

    function txGasPrice() public view returns (uint) {
        return tx.gasprice;
    }
}
