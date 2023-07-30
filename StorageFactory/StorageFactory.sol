// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{

    // when viewing this, this will returen the address
    // making it an array
    SimpleStorage[] public simpleStorageArray;

    // a function that can deploy the simple storage contract
    function createSimpleStorageContract() public {
        // deploy
        // creating a simple storage and add it to the array
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // We need 2 things:
        // address and ABI

        // using the index to access the contract object in the array
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        // use the retrive function from the other contract
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}