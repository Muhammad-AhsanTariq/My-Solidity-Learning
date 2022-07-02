// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract playerState{
    
 
   struct Player {
       string name;  
       uint id ;
       address addr; 
   }

     mapping(address => Player) public PlayerMapping;
     mapping(address => bool) public PlayerAddress;

   event AddingNewPlayer (
       string  name,
       uint id,
       address addr
   );

   address public owner;
 constructor() {
        owner = msg.sender ;
    }
    modifier onlyme() {
        require(owner==msg.sender, "Unauthorized User");
        _;
    }
      


   function EnablePlayer(address _anyname) external onlyme{
    
       PlayerAddress[_anyname] = true;
      
    
   }
   
   function DisablePlayer(address _anyname) external onlyme {
        
       PlayerAddress[_anyname] = false;
   }

 
 // Create Player
uint public playerCount;
address[] public players;
   
   function createNewPlayer(
       string memory _name,
       address _addr,
       uint _id
   ) public
     
   {
       require(PlayerAddress[msg.sender],"not match");
       playerCount++;
       PlayerMapping[msg.sender] = Player(_name, _id, _addr);
       players.push(msg.sender);
       emit AddingNewPlayer(_name,_id,_addr);

   }

   function UpdatingPlayer(
       
       string memory _name,
       address _addr,
       uint _id
   )
   external 
   {
       PlayerMapping[msg.sender].name = _name;
       PlayerMapping[msg.sender].addr = _addr;
       PlayerMapping[msg.sender].id = _id;
       
   }

   function getPlayerDetails(address i) public view returns (string memory, uint, address) {
        return ( PlayerMapping[i].name, PlayerMapping[i].id, PlayerMapping[i].addr);
    }

     function getPlayer() public view returns( address [] memory ){
        return(players);
    }
}
