// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    // Keep track of the current state of the betting round
    enum State {
        IDLE,
        BETTING
    }

    uint private index;

    struct Bet {
        address payable[] players;
        State currentState;
        uint maxNumPlayers;
        uint moneyRequiredToBet;
    }
    // An array of Bet structs
    Bet[] public bets;

    // House will take some fee for each betting round
    uint public houseFee;

    // Only admin should be able to create a betting round and cancel it
    address public admin;
    
    constructor(uint fee) {
        require(fee > 0, 'Fee should be greather than 1');
        admin = msg.sender;
        houseFee = fee;
    }
    
    // Create a new betting round which will change the state to State.BETTING
    function createBet(uint numPlayers, uint betMoney) external onlyAdmin() {
        address payable[] memory _players;
        bets.push(Bet({players: _players, currentState: State.BETTING, maxNumPlayers: numPlayers, moneyRequiredToBet: betMoney}));
        index++;
    }
    
    // Allow the players to bet in the current betting round
    // If we reach the max number of players, we decide the winner 
    function bet(uint betId) external payable inState(betId, State.BETTING) {
        uint moneyRequiredToBet = bets[betId].moneyRequiredToBet;
        require(msg.value == moneyRequiredToBet, 'Can only bet exactly the bet size');

        uint maxNumPlayers = bets[betId].maxNumPlayers;
        address payable[] storage players = bets[betId].players;
        players.push(payable(msg.sender));
        if(players.length == maxNumPlayers ) {
            // Pick a winner 
            uint winner = _randomModulo(maxNumPlayers);
            // (moneyRequiredToBet * maxNumPlayers) is the total amount of money in the lottery pool
            // (100 - houseFee) / 100 is the percentage of the money remaining to each player 
            // after houseFee is taken from the lottery pool
            // Send the money to the winner
            address payable winnerPlayer = payable(players[winner]);
            winnerPlayer.transfer((moneyRequiredToBet * maxNumPlayers) * (100 - houseFee) / 100);
            // Cleanup the data by removing the betting round data
            delete bets[betId];
        }
    }
    
    // Cancel the current betting round which will change the state to State.IDLE
    // By cancelling, we are basically sending back the Ether sent by different players
    // because the betting round got cancelled 
    function cancel(uint betId) external inState(betId, State.BETTING) onlyAdmin() {
        State currentState = bets[betId].currentState;
        uint moneyRequiredToBet = bets[betId].moneyRequiredToBet;
        address payable[] storage players = bets[betId].players;
        for(uint i = 0; i <= players.length-1; i++) {
            address payable player = payable(players[i]);
            player.transfer(moneyRequiredToBet);
        }
        delete bets[betId];
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
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % modulo;
    }
    
    modifier inState(uint betId, State state) {
        State currentState = bets[betId].currentState;
        require(state == currentState, 'Current state does not allow this');
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, 'Only admin can perform this operation');
        _;
    }
}