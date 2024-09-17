pragma solidity ^0.8.10;

contract VulnerableBank {
    mapping (address => uint) userBalance;
   
    function getBalance(address u) public view returns(uint){
        return userBalance[u];
    }

    function addToBalance() public payable {
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public {
        // send userBalance[msg.sender] ethers to msg.sender
        // if msg.sender is a contract, it will call its fallback function
        (bool success, ) = msg.sender.call{value: userBalance[msg.sender]}("");
        if (!success) {
            revert();
        }
        userBalance[msg.sender] = 0;
    }
}