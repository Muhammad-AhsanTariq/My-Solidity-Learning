// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract events{
    
event message(address sender,address to,string message);
function sendmessage (address _to, string memory _message)public{

    emit message( msg.sender,_to,_message);

}
}
