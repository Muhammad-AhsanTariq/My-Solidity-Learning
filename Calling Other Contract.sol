// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Callme {
    uint public x;
    uint public value;
    uint public addv1;
    

    function setX(uint _x) public returns(uint) {
        x = _x;
        return x;
    }

    function add(uint _a, uint _b) public returns(uint) {
        addv1 = _a + _b;
        return addv1;
    }

     function setXandSendEther(uint _x) public payable returns (uint , uint) {

        x = _x;
        value = msg.value;
        
        return (x , value);
    }
//0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005
}

contract Caller {
uint x;
     function setValueOFContractCallme(Callme _all , uint _x) public {
         
         uint x = _all.setX(_x);
        
     }
     function addValueOfContractCallme(Callme _all , uint _x, uint _y) public {
              uint x = _all.add(_x , _y);          
     }
     function setXandSendEther(Callme _call , uint _x) public payable {
            (uint x,uint value)= _call.setXandSendEther{value : msg.value}(_x);
     }


}
