// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC20, Ownable {


   mapping(address => uint) public lockTime;
   mapping (address => uint) public  balance;
   

    constructor() ERC20("MyToken", "MTK") {
     }

    // calling SafeMath will add extra functions to the uint data type
    using SafeMath for uint; // you can make a call like myUint.add(123
    uint initialTimestamp;
    uint public releaseTime;
    uint public rsrvBal;
    uint public newVal;

    function setLockTime(uint _seconds) public {
      initialTimestamp = block.timestamp;
      if (_seconds > 0) {
               
         releaseTime = initialTimestamp.add(uint256(_seconds));
        }
        // the add function below is from safemath and will take care of uint overflow
         lockTime[msg.sender] = lockTime[msg.sender].add(_seconds);
      }

    function mint( address to, uint256 val) public {
      
        rsrvBal= val.div(100).mul(30);
        newVal=val-rsrvBal;
          
         if(block.timestamp > releaseTime){
          balance[to] = balance[to].add(rsrvBal);
          _mint(to,rsrvBal);
        
        } 
        if(block.timestamp < releaseTime){
          balance[to] += balance[to].add(newVal);
          _mint(to,newVal);
           
        }
    }
  }
