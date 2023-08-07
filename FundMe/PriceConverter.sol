// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// import from github
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// paste all the functions into here
library PriceConverter {
    // use this function to get the ETH price, so we can convert USD => ETH
    function getPrice() internal view returns(uint256){
        // need ABI and address of the contract of chainlink
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 ETH/USD on sepholia
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceFeed.latestRoundData();
        // making it 18 digits
        price = price * 1e10;
        return uint256(price);
    }
    
    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getDecimal() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.decimals();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

}