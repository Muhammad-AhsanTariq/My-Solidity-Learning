// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

 contract crowdFund is ERC20,Ownable {

   
    constructor() ERC20("MyToken", "MTK") {
          
        pledgeAddr = (address(this));
   
    }
    
 struct Campaign {

        address creator;
        uint goal;
        uint pledged;
        uint startAt;
        uint endAt;
        bool claimed;
    }
  struct user{

      address donor;
      address to;
  }

    uint public _startAt;
    uint public _endAt;
    uint public campaignId;
    address public pledgeAddr;
    //address public tokenAddr= address(this);
  
    // Mapping from id to Campaign
    mapping(uint => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint => mapping(address => uint)) public pledgedAmount;
    mapping(uint => user)public _address;
   
   function mint( address to,uint256 amount) public{
        _mint(to, amount);
    }

    function launch(
        uint _goal
       ) public onlyOwner {

        _startAt = block.timestamp;
        _endAt = block.timestamp+uint(600);
        campaignId++;
        campaigns[campaignId] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

    }

    function pledges(address from,uint _id, uint _amount) public  {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");
         
        campaign.pledged += _amount;
      
      
        pledgedAmount[_id][from] += _amount;
       _address[_id] = user(from,pledgeAddr);
       

       _transfer(from,pledgeAddr,_amount);
    
    }

    function unpledge(uint _id, uint _amount) public {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");
         address to=  _address[_id].donor;
       
        campaign.pledged -= _amount;
        pledgedAmount[_id][to] -= _amount;
       
      
        _transfer(pledgeAddr,to, _amount);

       
    }

    function claim(uint _id) public {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp >= campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        _transfer(pledgeAddr,campaign.creator, campaign.pledged);

    
    }

      function cancel(uint _id) public onlyOwner {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp >= campaign.startAt, "started");

        delete campaigns[_id];
       
    }

    function refund(uint _id) public {
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp >= campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");
        
        address to=  _address[_id].donor;
        uint bal = pledgedAmount[_id][to];
        pledgedAmount[_id][to] = 0;
         
        _transfer(pledgeAddr,to, bal);

      
    }


}
