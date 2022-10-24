// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";

contract WEB3101Counters {
    using Counters for Counters.Counter;

    Counters.Counter public counter;

    function getCurrentCounter() public view returns (Counters.Counter memory) {
        return counter;
    }

    function incrementCounter() public {
        Counters.increment(counter);
    }
}
