// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

    mapping(address => uint) balances; 
    
    uint public totalSupply;
    address public owner;

    constructor(uint _initialSupply) public{
        owner = msg.sender;
        balances[msg.sender] = totalSupply = _initialSupply;
  }

    function transfer(address _to, uint _value) public returns (bool) {
    
        require(balances[msg.sender] - _value >= 0, "You're not the owner!");
        
        balances[msg.sender] -= _value;
        //underflows when you send more than your balance
        balances[_to] += _value;
    
        return true;
  }


    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
  }

    function getOwnerBalance() public view returns(uint)
    {
        return  balances[owner];
    }

}

//Token owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 
//Hackers account = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db - 20 tokens
//Hacker mints new tokens here: 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB 