// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Function contract 
////////////////// Start ///////////////

 contract funcBehaviour {
 
    uint age = 30;
   
    function getAge() public view returns (uint){
        return age;
    }
    
    function GetNumber() public pure returns (uint){
         uint Number =  150;
         return Number;
    }

    uint public recieveamount; //1

    function GetAmount() public payable
    {
     recieveamount = recieveamount + msg.value; //1
    }
}
