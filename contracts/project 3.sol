// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract bankContract {

    address public owner = msg.sender; 

    /*The purpose of mapping ties the sender of ETH to their address 
    so our contracts know who sent the ETH and stores it*/
    mapping(address => uint) balances;

    function deposit() public payable {
       balances[msg.sender] += msg.value;
    }
    //receive() external payable {}

    function withDraw(uint _amount) public {
        require(balances[msg.sender]>= _amount, "error ,, insufficient amount");
        balances[msg.sender] -= _amount;
        (bool sent,) = msg.sender.call{value: _amount}("send");
        require(sent, "Failed to Complete");
    } 

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function Kill() public {
        require(msg.sender == owner, "you are not owner");
        selfdestruct(payable(msg.sender));
    }
}