// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint8 public counter;
    constructor () {
        counter = 0;
    }

    function count () public {
        counter = counter+ 1;
    }

    function add (uint8 x) public {
        counter = counter + x;
    }

}
