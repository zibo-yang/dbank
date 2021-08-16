// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract dBank {

  //assign Token contract to variable
  Token private token;
  uint public interestPerSecond;
  uint public accruedInterest;
  //add mappings
  mapping(address => uint) public etherBalanceOf;
  mapping(address => uint) public depositStart;
  mapping(address => bool) public isDeposited;

  //add events
  event Deposit(address indexed user, uint etherAmount, uint timeStart);
  event Withdraw(address indexed user, uint etherAmount, uint timeEnd);

  //pass as constructor argument deployed Token contract
  constructor(Token _token) public {
    token = _token;
    //assign token deployed contract to variable
  }

  function deposit() payable public {
    //check if msg.sender didn't already deposited funds
    require(isDeposited[msg.sender] == false, "Error, deposit already active");
    //check if msg.value is >= than 0.01 ETH
    require(msg.value >=1e16, "Error. deposit must be >= 0.01 ETH");

    etherBalanceOf[msg.sender] = msg.value;
    depositStart[msg.sender] = block.timestamp;
    //increase msg.sender ether deposit balance
    //start msg.sender hodling time

    isDeposited[msg.sender] = true;
    //set msg.sender deposit status to true

    emit Deposit(msg.sender, msg.value, block.timestamp);
    //emit Deposit event
  }

  function withdraw() public {
    require(isDeposited[msg.sender] == true, "Error, deposit doesn't finish");
    //check if msg.sender deposit status is true

    uint allDeposit = etherBalanceOf[msg.sender];
    //assign msg.sender ether deposit balance to variable for event

    uint hodlTime = block.timestamp - depositStart[msg.sender];
    //check user's hodl time

    interestPerSecond = 31668017 * (allDeposit/ 1e16);
    //calc interest per second
    accruedInterest = hodlTime * interestPerSecond;
    //calc accrued interest

    msg.sender.transfer(allDeposit);
    //send eth to user
    token.mint(msg.sender, accruedInterest);
    //send interest in tokens to user

    dBank.depositStart[msg.sender] = 0;
    dBank.etherBalanceOf[msg.sender] = 0;
    isDeposited[msg.sender] = false;
    //reset depositer data
    emit Withdraw(msg.sender, allDeposit, block.timestamp);
    //emit event
  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan

    //add msg.value to ether collateral

    //calc tokens amount to mint, 50% of msg.value

    //mint&send tokens to user

    //activate borrower's loan status

    //emit event
  }

  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}