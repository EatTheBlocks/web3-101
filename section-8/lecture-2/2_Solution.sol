// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* Use custom error type to define an error called "TxNotExists" that takes the argument "transactionIndex"
         This error will be thrown whenever the user tries to approve a transaction that does not exist.
*/
error TxNotExists(uint transactionIndex);
/* Use custom error type to define an error called "TxAlreadyApproved" that takes the argument "transactionIndex"
         This error will be thrown whenever the user tries to approve a transaction that has already been approved.
*/
error TxAlreadyApproved(uint transactionIndex);
/* Use custom error type to define an error called "TxAlreadySent" that takes the argument "transactionIndex"
         This error will be thrown whenever the user tries to approve a transaction that has already been sent.
*/
error TxAlreadySent(uint transactionIndex);

contract MultiSigWallet {
    // Declare an event called "Deposit" that will be emitted whenever the smart contract receives some ETH
    event Deposit(address indexed sender, uint amount, uint balance);

    /* Declare an event called "CreateWithdrawTx" that will be emitted whenever one of the owners tries to
             initiates a withdrawal of ETH from the smart contract
    */
    event CreateWithdrawTx(
        address indexed owner,
        uint indexed transactionIndex,
        address indexed to,
        uint amount
    );
    /* Declare an event called "ApproveWithdrawTx" that will be emitted whenever one of the owners tries to
             approve an existing withdrawal transaction
    */
    event ApproveWithdrawTx(
        address indexed owner,
        uint indexed transactionIndex
    );

    // Declare an array to keep track of owners
    address[] public owners;

    /* Declare a mapping called "isOwner" from address -> bool that will let us know whether a praticular address is one of the
             owners of the multisig smart contract wallet
    */
    mapping(address => bool) public isOwner;
    // Initialize an integer called "quorumRequired" to keep track of the total number of quorum required to approve a withdraw transaction
    uint public quorumRequired;

    /* Declare a struct called "WithdrawTx" that will be used to keep track of withdraw transaction that owners create. This
             struct will define four properties:
             1) Keep track of the receiver address called "to"
             2) Keep track of the amount of ETH to be withdrawn called "amount"
             3) Keep track of the current number of quorum reached called "approvals"
             4) Keep track of the status of the transaction whether it has been sent called "sent"
    */
    struct WithdrawTx {
        address to;
        uint amount;
        uint approvals;
        bool sent;
    }

    /* Declare a mapping called "isApproved" that will keep track of whether a particular withdraw transaction has
             already been approved by the current caller. This is a mapping from transaction index => owner => bool
    */
    mapping(uint => mapping(address => bool)) public isApproved;

    // Declare an array of WithdrawTxstruct to keep track of the list of withdrawal transactions for this multisig wallet
    WithdrawTx[] public withdrawTxes;
}
