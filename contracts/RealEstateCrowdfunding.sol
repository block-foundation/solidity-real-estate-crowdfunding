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

/**
 *  @title Real Estate Crowdfunding Contract
 *  @dev A crowdfunding contract where potential homebuyers or real estate 
 *  developers could raise funds for their projects.
 */
contract RealEstateCrowdfunding {


    // Parameters
    // ========================================================================

    Campaign[] private campaigns;


    // Structs
    // ========================================================================

    /**
     *  @title Campaign
     *  @dev The struct for the campaign details.
     *  @param beneficiary The owner of the property who receives the funds.
     *  @param goal Target amount to be raised in wei.
     *  @param deadline Fundraising deadline as UNIX timestamp.
     *  @param raisedAmount The amount of wei raised.
     *  @param investors A mapping of the investors' addresses to their
     *  contributions.
     */
    struct Campaign {
        address payable beneficiary;
        uint256 goal;
        uint256 deadline;
        uint256 raisedAmount;
        mapping(address => uint256) investors;
    }


    // Methods
    // ========================================================================

    /**
     *  @notice Create a new crowdfunding campaign.
     *  @dev Start a new campaign by specifying the goal and duration. The
     *  sender becomes the beneficiary.
     *  @param goal The amount of wei needed for the project.
     *  @param duration The number of seconds that the campaign will be active.
     *  @return campaignID The ID of the newly created campaign.
     */
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


    // Methods
    // ========================================================================

    /**
     *  @notice Contribute to a crowdfunding campaign.
     *  @dev Add funds to a campaign, the campaign must not be ended and the
     *  raisedAmount
     *  plus the new contribution should not exceed the goal.
     *  @param campaignID The ID of the campaign to contribute to.
     */
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

    /**
     *  @notice Check the contribution of the message sender to the campaign.
     *  @dev Returns the amount contributed by the message sender to the
     *  specific campaign.
     *  @param campaignID The ID of the campaign to check contribution from.
     *  @return The amount of wei contributed by the message sender.
     */
    function checkContribution(
        uint256 campaignID
    ) public view returns (uint256) {
        return campaigns[campaignID].investors[msg.sender];
    }
    
    /**
     *  @notice Withdraw funds from the campaign.
     *  @dev Allows the beneficiary of the campaign to withdraw the funds after
     *  the goal has been met and the deadline has passed.
     *  @param campaignID The ID of the campaign to withdraw funds from.
     */
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

    /**
     *  @notice Refund the contribution of the message sender.
     *  @dev Allows an investor to get a refund if the campaign did not reach
     *  its goal and the deadline has passed.
     *  @param campaignID The ID of the campaign to get a refund from.
     */
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
