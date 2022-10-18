// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract crowdFunding {

    address public owner;
    mapping (address => bool) contributors;

    uint public minimumFunds;


        struct Withdrawal {
        string description;
        uint value;
        address recipient;
        bool complete;
        mapping(uint => bool) approvals;
    }

    Withdrawal[] public withdrawals;


constructor (uint minimum , address creator) public  {
    owner = creator;
    minimumFunds = minimum;
}

function contribute() public payable {
    require(msg.value >= minimumFunds);
    contributors[msg.sender] = true;
}

modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}

modifier onlyContributer() {
    require(contributors[msg.sender]);
_;
}

function createWithdrawal(string description, uint value, address recipient) public onlyOwner {
    Withdrawal memory newwithdrawal = Withdrawal({
        description: description,
        value: value,
        recipient: recipient,
        complete: false
    });
    withdrawals.push(newwithdrawal);
}

function approvawithdrawal(uint index) public onlyContributer{
    Withdrawal storage withdrawal = withdrawals[index];

    require(!withdrawal.approvals[msg.sender]); 
    withdrawal.approvals[msg.sender] = true;
}

function finalizeWithdrawal(uint index) public onlyOwner {
    Withdrawal storage withdrawal = withdrawals[index];
    require(!withdrawal.complete);
    withdrawal.complete = true;

    withdrawal.recipient.transfer(withdrawal.value);
    
}

}