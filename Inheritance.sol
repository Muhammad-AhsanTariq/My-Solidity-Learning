// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Student {

     uint public age;
     string public name;

      function setAge(uint _age) public {
      age = _age;
      }

      function setName(string memory _name) public {
      name = _name;
      }

 }

contract Teacher is Student {
    
    string public setDesigna;
    
     function setDesignation(string memory _set) public {
       setDesigna = _set;
     }
 }
 
