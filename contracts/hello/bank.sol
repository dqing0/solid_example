// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    address public owner;
    mapping (address => uint256) private balances;
    // An array to store the users with the highest deposits
    address[] public topDepositors;

    // Declare an event triggered on withdrawal
    event Withdrawal(address indexed to, uint256 amount);
    // Declare an event triggered on deposit
    event Deposit(address indexed from, uint256 amount);
    

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner ,"Only owner can call this fn");
        _;
    }

    receive() external payable { 
        deposit();
    }

    function deposit() public payable {
        require(msg.value > 0,"Deposit amount should greater than 0");
        balances[msg.sender] += msg.value;
        // Update the leaderboard
        updateTopDepositors(msg.sender);
        // Trigger the event
        emit Deposit(msg.sender, msg.value);
    }

    function withDraw(uint256 amount) public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0,"Contract balance is 0");
        require(balance >= amount,"Insufficient contract balance");
        payable(owner).transfer(amount);
        // Trigger the withdrawal event
        emit Withdrawal(owner, amount);
    }

    function updateTopDepositors(address depositor) internal {
        // Set a flag to avoid duplication
        bool exists = false;

        // Traverse the array, if the current address already exists in topDepositors, exit the loop
        for (uint256 i = 0; i < topDepositors.length; i++) {
            if (topDepositors[i] == depositor) {
                exists = true;
                break;
            }
        }
        // If it does not exist, add the current address to the array
        if (!exists) {
            topDepositors.push(depositor);
        }

        for (uint256 i = 0; i < topDepositors.length; i++) {
            for (uint256 j = i + 1; j < topDepositors.length; j++) {
                if (balances[topDepositors[i]] < balances[topDepositors[j]]) {
                    address temp = topDepositors[i];
                    topDepositors[i] = topDepositors[j];
                    topDepositors[j] = temp;
                }
            }
        }

        // After the array length exceeds 3, only keep the top three.
        if (topDepositors.length > 3) {
            topDepositors.pop();
        }
    }

     // View the account balance based on the specified address
    function getBalance(address addr) public view returns(uint256) {
        return balances[addr];
    }

    // Return the deposit leaderboard
    function getTopDepositors() public view returns (address[] memory) {
        return topDepositors;
    }
}