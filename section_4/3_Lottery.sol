// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Lottery {
    // Keep track of the current state of the betting round
    enum State {
        IDLE,
        BETTING
    }

    // Keep track of all the players in the lottery
    address payable[] public players;
    // We are going to define a variable to keep track of the current state
    State public currentState = State.IDLE;
    // Each betting round will have this number of players
    uint public maxNumPlayers;
    // The players can only bet with this exact amount to keep it fair
    uint public moneyRequiredToBet;
    // House will take some fee for each betting round
    uint public houseFee;
    // Only admin should be able to create a betting round and cancel it
    address public admin;
    
    constructor(uint fee) {
        require(fee > 1 && fee < 99, 'Fee should be between 1 and 99');
        admin = msg.sender;
        houseFee = fee;
    }
    
    // Create a new betting round which will change the state to State.BETTING
    function createBet(uint numPlayers, uint betMoney) external inState(State.IDLE) onlyAdmin() {
        maxNumPlayers = numPlayers;
        moneyRequiredToBet = betMoney;
        currentState = State.BETTING;
    }
    
    // Allow the players to bet in the current betting round
    // If we reach the max number of players, we decide the winner 
    function bet() external payable inState(State.BETTING) {
        require(msg.value == moneyRequiredToBet, 'Can only bet exactly the bet size');
        players.push(payable(msg.sender));
        if(players.length == maxNumPlayers ) {
            // Pick a winner 
            uint winner = _randomModulo(maxNumPlayers);
            // (moneyRequiredToBet * maxNumPlayers) is the total amount of money in the lottery pool
            // (100 - houseFee) / 100 is the percentage of the money remaining to each player 
            // after houseFee is taken from the lottery pool
            // Send the money to the winner
            players[winner].transfer((moneyRequiredToBet * maxNumPlayers) * (100 - houseFee) / 100);
            // Change the state to IDLE 
            currentState = State.IDLE;
            // Cleanup the data by removing the players from the betting round
            delete players;
        }
    }
    
    // Cancel the current betting round which will change the state to State.IDLE
    // By cancelling, we are basically sending back the Ether sent by different players
    // because the betting round got cancelled 
    function cancel() external inState(State.BETTING) onlyAdmin() {
        for(uint i = 0; i < players.length; i++) {
            players[i].transfer(moneyRequiredToBet);
        }
        delete players;
        currentState = State.IDLE;
    }
    
    function _randomModulo(uint modulo) view internal returns(uint) {
        // Getting the remainder value will ensure that the random number we get will always 
        // be less than the "modulo"
        // block.timestamp can be manipulated by itself
        // block.difficulty changes all the time so we combine multiple things to generate a good random no
        // we produce a keccak256 hash that represents the combination of block.timestamp and block.difficulty
        // keccak256 takes one argument so we use abi.encodePacked to concatenate into one value(which is the encoding in bytes)
        // We then cast the final number to an integer then divide by module and get the remainder 
        uint randomNumber;
        randomNumber = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        randomNumber = randomNumber % modulo;
        return randomNumber; 
    }
    
    modifier inState(State state) {
        require(state == currentState, 'Current state does not allow this');
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, 'Only admin can perform this operation');
        _;
    }
}