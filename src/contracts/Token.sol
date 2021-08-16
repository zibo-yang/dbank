// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //add minter variable
  address public minter;
  //add minter changed event
  event MinterChanged(address indexed from, address to);

  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    //assign initial minter
    minter = msg.sender;
  }

  //Add pass minter role function
  function passMinterRole(address dBank) public returns(bool){
    require(minter == msg.sender,"Error! msg.sender doesn't have minter role.");
    minter = dBank;
    emit MinterChanged(msg.sender,dBank);
    return true;

  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(minter == msg.sender,"Error! msg.sender doesn't have minter role.");
		_mint(account, amount);
	}
}