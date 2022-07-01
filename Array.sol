// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract array{
uint[] public myArray; // dynamic
//uint[] public myArray1 =[1,2,3,4];
//uint[10] public myfixedArray;               //fixed
function push(uint _value) public{
myArray.push(_value);
}
function pop()public{
myArray.pop();
}
function getlength() public view returns(uint){
return myArray.length;
}
function removearray (uint _index) public {
    delete myArray[_index];
    pop();
    

}
 }
