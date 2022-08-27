// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Nadra{
   
  struct UserReg{
        string  Name;
        string  Address;
        string  City;
        uint    Cnic;
        uint    Dob;
    }
  mapping(uint => UserReg) private User;
  uint public UserCount;

   function addDetails(string memory _name,string memory _Address, string memory _city,uint _cnic,uint _dob) public {
        UserCount++;
        User[UserCount] = UserReg( _name, _Address, _city,_cnic,_dob);
         
    }

    function getDetailsById(uint id) public view returns (UserReg memory) {
        return User[id];
    }

    function getAllDetails()public view returns(UserReg[] memory){
    UserReg[] memory getDetails= new UserReg[](UserCount);
    for(uint i=1; i< UserCount; i++){
    getDetails[i]=User[i];
    }
    return getDetails;
    }
 }
