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


// Import necessary modules from hardhat
import { ethers, upgrades } from "hardhat";

// The main function that will be executed during the deployment
async function main() {
  // Retrieve the signers from ethers.js
  const [deployer] = await ethers.getSigners();

  // Log the address of the account deploying the contract
  console.log(
    "Deploying contracts with the account:",
    await deployer.getAddress()
  );

  // Log the account balance of the deployer before deployment
  console.log("Account balance:", (await deployer.getBalance()).toString());

  // Get the ContractFactory of your Contract
  const RealEstateCrowdfundingFactory = await ethers.getContractFactory("RealEstateCrowdfunding");

  // Deploy the contract and store the resulting Contract object
  const realEstateCrowdfunding = await RealEstateCrowdfundingFactory.deploy();

  // Log the address of the newly deployed contract
  console.log("RealEstateCrowdfunding contract address:", realEstateCrowdfunding.address);

  // Wait until the transaction that deployed the contract has been mined
  await realEstateCrowdfunding.deployed();

  // Log the address of the contract again once it has been deployed
  console.log("RealEstateCrowdfunding deployed to:", realEstateCrowdfunding.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))  // Close the process
  .catch((error) => {            // Catch any errors
    console.error(error);         // Log the error
    process.exit(1);              // Close the process
  });
