// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// inheritence

import "./SimpleStorage.sol";

// using the keyword "is" making it a simple storage
contract ExtraStorage is SimpleStorage{
    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 20;
    }
}