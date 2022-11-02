// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// TODO: Import Wallet.sol here
// TODO: Import ERC20 from Openzeppelin

contract Exercise {
    // TODO: Declare the events to be used in the 5 required functions

    // TODO: You can use a struct or mapping to keep track of all the current stakes in the staking pool.
    // Make sure to track the wallet, the total amount of ETH staked, the start time of the stake and the
    // end time of the stake

    // TODO: It may be a good idea to keep track of all the new stakes in an array

    // This defines the total percentage of reward(WEB3 ERC20 token) to be accumulated per second
    uint256 public constant percentPerBlock = 1; // Bonus Exercise: use more granular units

    // TODO: Define the constructor and make sure to define the ERC20 token here
    constructor() {}

    // TODO: This should create a wallet for the user and return the wallet Id. The user can create as many wallets as they want
    function walletCreate() public returns (uint256 walletId) {}

    // TODO: This should let users deposit any amount of ETH into their wallet
    function walletDeposit(uint256 _walletId)
        public
        payable
        isWalletOwner(_walletId)
    {}

    /*
      TODO: This should let users stake the current ETH they have in their wallet to the staking pool. The user should 
      be able to stake additional amount of ETH into the staking pool whereby doing so will first reward the users with 
      the accumulated WEB3 ERC20 token and then reset the timestamp for the overall stake. When you stake your ETH into 
      the pool, what happens is the ETH is withdrawn from the wallet to the staking pool so make sure to call the withdraw 
      function of the wallet here to handle this.
    */
    // Bonus Exercise: Let user stake any amount of ETH rather than the whole balance
    function stakeEth(uint256 _walletId) public isWalletOwner(_walletId) {
        // TODO: Ensure that the wallet balance is non-zero before staking
        // TODO: Transfer ETH from the wallet(Wallet contract) to the staking pool(this contract)
        // TODO: Reward with WEB3 tokens that the user had accumulated previously
    }

    // TODO: This will return the current amount of ETH that a particular wallet has staked in the staking pool
    function currentStake(uint256 _walletId) public view returns (uint256) {}

    /*
      TODO: This should let users unstake all their ETH they have in the staking pool. Doing so will automatically mint 
      the appropriate amount of WEB3 ERC20 tokens that have been accumulated so far. When you unstake your ETH from the pool, 
      the ETH is withdrawn from the staking pool to the user wallet so make sure to call the transfer function to handle this.
    */
    function unstakeEth(uint256 _walletId)
        public
        payable
        isWalletOwner(_walletId)
    {
        // TODO: Ensure that the user hasn't already unstaked previously
        // TODO: Transfer ETHB from the staking pool(this contract) to the wallet(Wallet contract)
        // TODO: Reward with WEB3 tokens that the user had accumulated so far
    }

    // TODO: This should let users withdraw any amount of ETH from their wallet
    function walletWithdraw(
        uint256 _walletId,
        address payable _to,
        uint _amount
    ) public payable isWalletOwner(_walletId) {}

    // TODO: This will return the current amount of ETH for a particular wallet
    function walletBalance(uint256 _walletId) public view returns (uint256) {}

    // TODO: This will return the total unclaimed WEB3 ERC20 tokens based on the user’s stake in the staking pool
    function currentReward(uint256 _walletId) public view returns (uint256) {}

    // TODO: This will return the total amount of wallets that are currently in the staking pool
    function totalAddressesStaked() public view returns (uint256) {}

    // TODO: This will return true or false depending on whether a particular wallet is staked in the staking pool
    function isWalletStaked(uint256 _walletId) public view returns (bool) {}

    // TODO: This will return the array of wallets
    function getWallets() public view returns (StakeWallet[] memory) {}

    // TODO: Implement the "receive()" fallback function so the contract can handle the deposit of ETH

    // TODO: Implement the modifier "isWalletOwner" that checks whether msg.sender is the owner of the wallet
    modifier isWalletOwner(uint256 walletId) {}
}
