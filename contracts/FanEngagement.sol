//SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FanToken is ERC20 {
    // Define the terms of the contract
    string public tokenName;
    uint public tokenSupply;

    // Define the parties involved
    address public owner;
    mapping(address => bool) public fans;

    // Define the constructor function
    constructor(string memory _tokenName, uint _tokenSupply) ERC20(_tokenName, "FT") {
        owner = msg.sender;
        tokenName = _tokenName;
        tokenSupply = _tokenSupply;
        _mint(owner, tokenSupply);
    }

    // Define the function for adding fans
    function addFan(address _fanAddress) public {
        require(msg.sender == owner, "Only the owner can add fans");
        fans[_fanAddress] = true;
    }

    // Define the function for rewarding fans
    function rewardFan(address _fanAddress, uint _rewardAmount) public {
        require(fans[_fanAddress], "Fan not found");
        require(_rewardAmount <= balanceOf(owner), "Insufficient funds to reward fan");
        transfer(_fanAddress, _rewardAmount);
    }

    // Define the function for checking the fan balance
    function checkFanBalance(address _fanAddress) public view returns (uint) {
        return balanceOf(_fanAddress);
    }
}
