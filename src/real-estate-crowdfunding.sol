// SPDX-License-Identifier: Apache-2.0


// Copyright 2023 Stichting Block Foundation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


pragma solidity ^0.8.19;


// ============================================================================
// Contracts
// ============================================================================

contract RealEstateCrowdfunding {

    struct Campaign {
        address payable beneficiary; // the owner of the property
        uint256 goal; // target amount to be raised in wei
        uint256 deadline; // fundraising deadline as UNIX timestamp
        uint256 raisedAmount; // amount raised
        mapping(address => uint256) investors;
    }

    Campaign[] private campaigns;


    // Methods
    // ========================================================================

    function createCampaign(
        uint256 goal,
        uint256 duration
    ) public returns (uint256 campaignID) {
        Campaign memory newCampaign;
        newCampaign.beneficiary = payable(msg.sender);
        newCampaign.goal = goal;
        newCampaign.deadline = block.timestamp + duration;
        campaigns.push(newCampaign);

        campaignID = campaigns.length - 1;
    }

    function contribute(
        uint256 campaignID
    ) public payable {
        require(
            block.timestamp <= campaigns[campaignID].deadline,
            "This campaign has ended"
        );
        require(
            campaigns[campaignID].raisedAmount + msg.value <= campaigns[campaignID].goal,
            "Campaign already funded"
        );
        
        campaigns[campaignID].investors[msg.sender] += msg.value;
        campaigns[campaignID].raisedAmount += msg.value;
    }

    function checkContribution(
        uint256 campaignID
    ) public view returns (uint256) {
        return campaigns[campaignID].investors[msg.sender];
    }
    
    function withdrawFunds(
        uint256 campaignID
    ) public {
        require(
            msg.sender == campaigns[campaignID].beneficiary,
            "Only campaign beneficiary can withdraw"
        );
        require(
            campaigns[campaignID].raisedAmount >= campaigns[campaignID].goal,
            "Fundraising goal not met"
        );
        require(
            block.timestamp >= campaigns[campaignID].deadline,
            "Deadline has not been reached"
        );

        campaigns[campaignID].beneficiary.transfer(campaigns[campaignID].raisedAmount);
    }

    function refund(
        uint256 campaignID
    ) public {
        require(
            block.timestamp > campaigns[campaignID].deadline,
            "Deadline has not been reached"
        );
        require(
            campaigns[campaignID].raisedAmount < campaigns[campaignID].goal,
            "The fundraising goal was met"
        );

        uint256 investorContribution = campaigns[campaignID].investors[msg.sender];
        require(
            investorContribution > 0,
            "You did not donate to this campaign"
        );

        campaigns[campaignID].investors[msg.sender] = 0;
        payable(msg.sender).transfer(investorContribution);
    }
}
