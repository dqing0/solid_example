// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract testAddr {
    function testTransfer(address payable x) public {
        address myAddress = address(this);

        if (myAddress.balance >= 10){
            x.transfer(10);
        }
    }
}