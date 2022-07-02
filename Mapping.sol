// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract map{

    mapping(uint => address) public myMap;

   function setvalue(uint _key , address _addr)public{
       myMap[_key] = _addr;
   } 
   function getvalue(uint _key)public view returns(address){
       return myMap[_key];
   }
   function deleteavalue(uint _key)public{
       delete myMap[_key];
   }
}
