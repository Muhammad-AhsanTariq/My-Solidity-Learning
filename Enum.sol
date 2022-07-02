// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract enumExample {

       enum Status {         
            Pending, 
            Approved,
            Reject      
       }

       Status public status;
       string public statusCheck; 

       function Approved() public {
           require(status == Status.Pending);
           status = Status.Approved;
           statusCheck =  "proved";

       }
       function Reject() public {
           require(status == Status.Approved);
           status = Status.Reject;
           statusCheck =  "Reject";
       }

}
