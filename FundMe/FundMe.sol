// get funds from users
// withdraw funds in the contract to our address 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// 796297
// 776151 after changing to constant variable
error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    // adding the constant keyword make this not changable
    uint256 public constant MIN_USD = 100 * 1e18;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    } 
    // keep track of ppl who send fund
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // everyone should be able to call this function, so public
    // calling this should send a amount of fund into the contract
    function fund() public payable{
        // msg.value will be the amount of eth that the user is sending while calling this function
        require(msg.value.getConversionRate() >= MIN_USD, "send more than 100 USD!");
        funders.push(msg.sender); // add this sender to the funder list
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // the function to take the money out of the contract
    function withdraw() public onlyOwner {

        for (uint256 i = 0; i < funders.length; i++){
            address funder = funders[i]; // this will return a address
            addressToAmountFunded[funder] = 0;
        }

        // resetting the funders array
        funders = new address[](0);

        // withdrawing the fund
        // 3 ways:

        // transfer
        // transfer all the balance of the current address (the contract) to the msg.sender
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance); // will return true or false
        // require(sendSuccess, "Send Failed.");

        // call
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Send Failed.");

    }

    modifier onlyOwner{
        // making sure that only the contract owner can call this function
        // require(msg.sender == i_owner, "Sender is not owner");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }

}