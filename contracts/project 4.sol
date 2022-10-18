// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract crowdFunding {

    address public owner;
    uint public minimumFunds;
    address[] approvals;


    event indexedLog(address indexed sender);

    constructor() {
        owner = msg.sender;
    }

    function campaign(uint _x) public {
        require (msg.sender == owner);
        minimumFunds = _x;
    }

    function contribute () public payable {
        require (msg.value > minimumFunds);
        emit indexedLog(msg.sender);
        approvals.push(msg.sender);   
    }

}