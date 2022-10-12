contract MultiSigWallet {
    // Declare an array of WithdrawTxstruct to keep track of the list of withdrawal transactions for this multisig wallet
    /* TODO: Declare a constructor that takes in a list of owners for the wallet and the total number of quorum that
           will be required for withdrawal to be confirmed.
 
      The constructor should do the following:
      - Ensure there is at least one owner
      - Ensure the quorum is greater than 0 but less than or equal to the number of owners
      - Ensure each owner is a valid owner(i.e. owner is not a zero address)
      - Ensure each owner is unique
    */
    // TODO: Declare a function modifier called "onlyOwner" that ensures that the function caller is one of the owners of the wallet
    // TODO: Declare a function modifier called "transactionExists" that ensures that transaction exists in the list of withdraw transactions
    // TODO: Declare a function modifier called "transactionNotApproved" that ensures that transaction has not yet been approved
    // TODO: Declare a function modifier called "transactionNotSent" that ensures that transaction has not yet been sent
}
