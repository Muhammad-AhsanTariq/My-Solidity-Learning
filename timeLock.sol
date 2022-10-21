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
    address public Owner;

    struct bal{
      uint mintAmnt;
      uint lockAmnt;
      uint time;
      address addr;
    }

   mapping(address=>mapping(uint=>bool))public transfrMap;
   mapping(address => bal) public lockedBal;
   
    
   error timeLimitNotComplete(); 
   
    constructor() ERC20("MyToken", "MTK") {
      Owner=msg.sender;
     }
    
    function mint( address to, uint val) public {
      require( msg.sender != Owner, "Owner not allow");
       
        lockedVal=val*30/100;
        mintVal=val-lockedVal;
    
        releaseTime = block.timestamp.add(uint256(10)); 
        
          _mint(to,mintVal);
          _mint(Owner,lockedVal);
          lockedBal[to]=bal(mintVal,lockedVal,releaseTime,to);
      
    }

    function withdraw(address to)public{
    
     require( Owner==msg.sender , "onlyOwner");
     require(transfrMap[to][lockedBal[to].time]==false, "already transfered claim balance");
     require(lockedBal[to].addr==to,"noTokenMinted");

     if(block.timestamp >= releaseTime){

      transfer(to,lockedBal[to].lockAmnt );
      transfrMap[to][lockedBal[to].time]=true;
    } 
    else{
      revert timeLimitNotComplete(); 
    }

    }
  }
