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


// Import necessary modules
import { ethers } from "hardhat";
import chai from "chai";
import { solidity } from "ethereum-waffle";
import { RealEstateCrowdfunding } from "../typechain/RealEstateCrowdfunding";


// Set up Waffle with Chai
chai.use(solidity);
const { expect } = chai;

// Main contract test block
describe("Real Estate Crowdfunding", () => {
    // Declare contract variable in the test scope
    let contract: RealEstateCrowdfunding;

    // Before running each test, deploy the contract
    beforeEach(
        async () => {
            const signers = await ethers.getSigners();
            const contractFactory = await ethers.getContractFactory(
                "RealEstateCrowdfunding",
                signers[0]
            );
            contract = (await contractFactory.deploy()) as RealEstateCrowdfunding;
            await contract.deployed();
        }
    );

    // Test case for campaign creation
    it(
        "should allow a user to create a campaign",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));
            const campaign = await contract.campaigns(0);

            // Verify that the beneficiary and goal are correctly set
            expect(campaign.beneficiary).to.equal(await contract.signer.getAddress());
            expect(campaign.goal).to.equal(ethers.utils.parseEther("10"));
        }
    );

    // Test case for contributing to a campaign
    it(
        "should allow a user to contribute to a campaign",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));

            const contributionAmount = ethers.utils.parseEther("5");
            await contract.contribute(0, { value: contributionAmount });

            const contribution = await contract.checkContribution(0);

            // Verify that the contribution was correctly registered
            expect(contribution).to.equal(contributionAmount);
        }
    );

    // Test case to prevent overfunding
    it(
        "should not allow a user to contribute more than the goal",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));

            // Attempt to overfund and expect a revert
            await expect(
                contract.contribute(0, { value: ethers.utils.parseEther("15") })
            ).to.be.revertedWith("Campaign already funded");
        }
    );

    // Test case for the withdrawal of funds when the goal is met
    it(
        "should allow the beneficiary to withdraw funds when the goal is met",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));
            await contract.contribute(
                0,
                { value: ethers.utils.parseEther("10") }
            );

            await contract.withdrawFunds(0);

            const campaign = await contract.campaigns(0);

            // Verify that funds were correctly withdrawn
            expect(campaign.raisedAmount).to.equal(0);
        }
    );

    // Test case to prevent premature withdrawal
    it(
        "should not allow the beneficiary to withdraw funds before the goal is met",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));
            await contract.contribute(
                0,
                { value: ethers.utils.parseEther("5") }
            );

            // Attempt premature withdrawal and expect a revert
            await expect(
                contract.withdrawFunds(0)
            ).to.be.revertedWith("Fundraising goal not met");
        }
    );

    // Test case to refund the contribution if the goal is not met
    it(
        "should allow a user to refund their contribution if the goal is not met",
        async () => {
            await contract.createCampaign(ethers.utils.parseEther("10"));
            await contract.contribute(
                0,
                { value: ethers.utils.parseEther("5") }
            );

            // simulate time passing
            await ethers.provider.send("evm_increaseTime", [86400 * 7]);
            // mine the next block
            await ethers.provider.send("evm_mine", []);

            await contract.refund(0);

            const contribution = await contract.checkContribution(0);

            // Verify that funds were correctly refunded
            expect(contribution).to.equal(0);
        }
    );

});
