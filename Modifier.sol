// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract modifierExample {

        address public owner;
        uint public sum;

        constructor() {
            owner = msg.sender;
        }       
        modifier OnlyOwner(){
          
            require(msg.sender == owner , "You are not the Owner");
            _;
        }

        function add() public OnlyOwner returns (uint)
         {
             sum = sum+1;//sum+=1
             return sum;            
        }
}

/////////////////// END //////////////////////
