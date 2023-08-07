// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract FallbackExample{
    uint256 public result;

    // special function
    // whenever ETH gets send to this contract without data, this gets trigger
    receive() external payable{
        result = 1;
    }

    // get executed when none of other functions match the given function signature
    fallback() external payable {
        result = 10;
    }

}