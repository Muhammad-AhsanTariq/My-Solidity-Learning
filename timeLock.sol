// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

  contract timeLock is ERC20, Ownable {
 
   // calling SafeMath will add extra functions to the uint data type
    using SafeMath for uint; // you can make a call like myUint.add(123
    uint public releaseTime;
    uint public lockedAmount;
    uint public mintAmount;
    uint public transactionId;
  
    struct userDetail{
      uint mintAmnt;
      uint lockAmnt;
      uint time;
      address addr;
    }

   mapping(uint=>userDetail)public User;
    
   error timeLimitNotComplete(); 
   
    constructor() ERC20("MyToken", "MTK") {}
    
    function mint( address to, uint amount) public {
      
      require( msg.sender != owner() , "Owner not allow");
       
      lockedAmount=amount*30/100;
      mintAmount=amount-lockedAmount;
      transactionId++;
      releaseTime = block.timestamp.add(uint256(600)); 
        
      _mint(to,mintAmount);
      _mint(owner(),lockedAmount);
      User[transactionId]=userDetail(mintAmount,lockedAmount,releaseTime,to);
  
    }

    function withdraw(uint transactionID) public onlyOwner {
    
     if(block.timestamp >= User[transactionID].time){

      transfer(User[transactionID].addr,User[transactionID].lockAmnt); 
    } 
    else{
      revert timeLimitNotComplete(); 
    }

    }
  }
