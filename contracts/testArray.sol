// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract testArray {
    uint256[10] tens;
    uint256[] public numbers;

    function copy(uint256[] calldata arrs) public returns (uint256 len) {
        numbers = arrs;
        return numbers.length;
    }

    function test(uint256 len) public pure {
        string[4] memory adaArr = ["This", "is", "an", "array"];
        uint256[] memory c = new uint256[](len);
    }

    function add(uint256 x) public {
        numbers.push(x);
    }

    function remove(uint256 i) public {
        uint256 len = numbers.length;
        if (i == len - 1) {
            numbers.pop();
        } else {
            numbers[i] = numbers[len - 1];
            numbers.pop();
        }
    }

    
}
