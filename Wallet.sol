// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract walletDevelopment {
 
        event Deposit(address depositAddress , uint amount , uint balance);
        event Withdraw(uint amount , uint balance);
        event Transfer(address to , uint amount , uint balance);


        address payable public owner;

        constructor() public payable {
            owner = payable(msg.sender);
        }

       function deposit(uint _amount) public payable{
           require(msg.value > 0 , "Please sent ether");
           emit Deposit(msg.sender , _amount , address(this).balance);
       }

        modifier onlyOwner() {
            require(msg.sender == owner , "Your are not the onwer");
         _;
        }

       function withdraw(uint _amount) public onlyOwner {
           owner.transfer(_amount);
           emit Withdraw(_amount , address(this).balance);

       }

       function transfer(address payable _to , uint _amount) public onlyOwner {
           
           _to.transfer(_amount);
           emit Transfer(_to , _amount ,  address(this).balance);
        }


       function getBalance() public view returns(uint){
           return address(this).balance;
       }
}
