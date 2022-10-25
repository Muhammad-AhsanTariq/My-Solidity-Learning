// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
  import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

  contract MyToken is ERC20, Ownable {
 
   // calling SafeMath will add extra functions to the uint data type
    using SafeMath for uint; // you can make a call like myUint.add(123
    uint public releaseTime;
    uint public lockedVal;
    uint public mintVal;
  

    struct bal{
      uint lockAmnt;
      uint time;
      address addr;
    }

   mapping(address=>mapping(uint=>bool))public transfrMap;
   mapping(address => mapping(uint=>bal)) public lockAcnt;
   
    
   error timeLimitNotComplete(); 
   
    constructor() ERC20("MyToken", "MTK") {}
    uint public transactionId;
    function mint( address to, uint val) public {
      require( msg.sender != owner() , "Owner not allow");
       
        lockedVal=val*30/100;
        mintVal=val-lockedVal;
         transactionId++;
        releaseTime = block.timestamp.add(uint256(600)); 
        
          _mint(to,mintVal);
          _mint(owner(),lockedVal);
          lockAcnt[to][transactionId].time=releaseTime;
          lockAcnt[to][transactionId].lockAmnt=lockedVal;
          lockAcnt[to][transactionId].addr=to;
    }

    function withdraw(address to) public onlyOwner{
    
     require(transfrMap[to][lockAcnt[to][transactionId].time]==false, "already transfered claim balance");
     require(lockAcnt[to][transactionId].addr==to,"noTokenMinted");

     if(block.timestamp >= lockAcnt[to][transactionId].time){

      transfer(to,(lockAcnt[to][transactionId].lockAmnt) );
      transfrMap[to][lockAcnt[to][transactionId].time]=true;
    } 
    else{
      revert timeLimitNotComplete(); 
    }

    }
  }
