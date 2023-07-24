// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract RealEstateCrowdfunding {
    struct Campaign {
        address payable beneficiary; // the owner of the property
        uint256 goal; // target amount to be raised in wei
        uint256 raisedAmount; // amount raised
        mapping(address => uint256) investors;
    }

    Campaign[] private campaigns;

    function createCampaign(uint256 goal) public returns (uint256 campaignID) {
        Campaign memory newCampaign;
        newCampaign.beneficiary = payable(msg.sender);
        newCampaign.goal = goal;
        campaigns.push(newCampaign);

        campaignID = campaigns.length - 1;
    }

    function contribute(uint256 campaignID) public payable {
        require(campaigns[campaignID].raisedAmount + msg.value <= campaigns[campaignID].goal, "Campaign already funded");
        
        campaigns[campaignID].investors[msg.sender] += msg.value;
        campaigns[campaignID].raisedAmount += msg.value;
    }

    function checkContribution(uint256 campaignID) public view returns (uint256) {
        return campaigns[campaignID].investors[msg.sender];
    }
    
    function withdrawFunds(uint256 campaignID) public {
        require(msg.sender == campaigns[campaignID].beneficiary, "Only campaign beneficiary can withdraw");
        require(campaigns[campaignID].raisedAmount >= campaigns[campaignID].goal, "Fundraising goal not met");

        campaigns[campaignID].beneficiary.transfer(campaigns[campaignID].raisedAmount);
    }
}
