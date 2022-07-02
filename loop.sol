// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract looping {
   
    uint public count;
   
    function lop (uint index) public returns (string[] memory) {
        string[] memory myArray = new string[] (index);
        for (uint i=0; i<index; i++){
            myArray[i]= 'ahsan' ;
             count++;
        }
       
        return myArray;
    }

}
