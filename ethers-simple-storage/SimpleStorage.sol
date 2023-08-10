// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract SimpleStorage {
    uint256 public favoriteNumber;

    // map a name to their favorite number
    mapping(string => uint256) public nameToFavoriteNumber;

    // ctreating a people struct including number and the name
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // People array
    People[] public people;

    // set the favorite number to the number we want
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
