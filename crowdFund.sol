// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MyToken is ERC20 {

    IERC20 public to;
    constructor(address _to) ERC20("MyToken", "MTK") {
      to = IERC20(_to);
    }
    

 struct Campaign {

        address creator;
        uint goal;
        uint pledged;
        uint startAt;
        uint endAt;
        bool claimed;
    }

    uint public _startAt;
    uint public _endAt;
    uint public count;
    // Mapping from id to Campaign
    mapping(uint => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint => mapping(address => uint)) public pledgedAmount;

   function mint(address To, uint256 amount) public  {
        _mint(To, amount);
    }

    function launch(
        uint _goal
       ) external {
        _startAt = block.timestamp;
        _endAt = block.timestamp+uint(600);
        require(_endAt >= _startAt, "end at > start at");
        

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

    }

    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp <= campaign.startAt, "started");

        delete campaigns[_id];
       
    }

    function pledge(uint _id, uint _amount) external  {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        to.transferFrom(msg.sender, address(this), _amount);

        
    }

    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        to.transfer(msg.sender, _amount);

       
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp >= campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        to.transfer(campaign.creator, campaign.pledged);

    
    }

    function refund(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        to.transfer(msg.sender, bal);

      
    }


}
