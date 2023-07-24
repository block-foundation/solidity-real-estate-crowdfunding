<div align="right">

  [![license](https://img.shields.io/github/license/block-foundation/solidity-real-estate-crowdfunding?color=green&label=license&style=flat-square)](LICENSE.md)
  ![stars](https://img.shields.io/github/stars/block-foundation/solidity-real-estate-crowdfunding?color=blue&label=stars&style=flat-square)
  ![contributors](https://img.shields.io/github/contributors/block-foundation/solidity-real-estate-crowdfunding?color=blue&label=contributors&style=flat-square)

</div>

---

<div>
    <img align="right" src="https://raw.githubusercontent.com/block-foundation/brand/master/logo/logo_gray.png" width="96" alt="Block Foundation Logo">
    <h1 align="left">Real-Esate Crowdfunding</h1>
    <h3 align="left">Block Foundation Smart Contract Series [Solidity]</h3>
</div>

---

<div>
<img align="right" width="75%" src="https://raw.githubusercontent.com/block-foundation/brand/master/image/repository_cover/block_foundation-structure-03-accent.jpg"  alt="Block Foundation">
<br>
<details open="open">
<summary>Table of Contents</summary>
  
- [Introduction](#style-guide)
- [Quick Start](#quick-start)
- [Contract](#contract)
- [Development Resources](#development-resources)
- [Legal Information](#legal-information)
  - [Copyright](#copyright)
  - [License](#license)
  - [Warning](#warning)
  - [Disclaimer](#disclaimer)

</details>
</div>

<br clear="both"/>

## Introduction

Introducing the Real Estate Crowdfunding Blockchain Solution

As technology continues to evolve and reshape industries globally, we are excited to bring you our latest development: a groundbreaking solution for the real estate industry. This innovative project applies the principles of blockchain technology to real estate crowdfunding, a venture we believe will revolutionize how individuals and organizations raise funds for real estate projects.

Our solution utilizes Smart Contract technology to facilitate, validate, and enforce negotiation or performance of an agreement. This automated, self-executing contract with the terms of the agreement directly written into code enables the democratization of real estate funding, rendering it more transparent, efficient, and accessible.

The Smart Contract has been designed with several features to enhance functionality and security. First, users can create a new crowdfunding campaign, specifying a goal amount to raise. Then, interested investors can contribute to the campaign while the contract keeps track of each investor's contribution and the total raised amount.

Moreover, the contract also has built-in mechanisms to safeguard the interests of both project creators and investors. For instance, if a crowdfunding campaign does not reach its funding goal by the specified deadline, the contract will automatically facilitate refunds to the investors.

This Blockchain-based Real Estate Crowdfunding solution signifies a step forward in the digital transformation of the real estate industry. It brings us one step closer to a decentralized financial landscape where anyone can participate in investment opportunities that were traditionally limited to institutions or the wealthy.

Join us on this journey to disrupt and democratize real estate crowdfunding, making it transparent, secure, and accessible to all.

## Quick Start

> Install

``` sh
npm i
```

> Compile

``` sh
npm run compile
```

## Contract

This is a simple Ethereum smart contract for crowdfunding real estate projects. This contract allows users to create new crowdfunding campaigns and contribute to existing ones.

This contract includes:

- A `Campaign` struct, which is used to hold data about each crowdfunding campaign.
- A `campaigns` array, which is used to hold all `Campaign` instances.
- The `createCampaign` function, which allows a user to start a new campaign with a specific goal amount.
- The `createCampaign` function accepts a duration parameter in seconds, which is added to the current timestamp to set the deadline for the campaign.
- The `contribute` function, which allows a user to contribute to a specific campaign.
- The `checkContribution` function, which allows a user to check how much they have contributed to a specific campaign.
- The `withdrawFunds` function, which allows the campaign owner to withdraw the funds after the campaign goal has been reached.
- The `withdrawFunds` function checks whether the deadline has been reached before allowing the beneficiary to withdraw the funds.
- A `deadline` variable in the Campaign struct, which is used to set a deadline for the crowdfunding campaign.
- The `contribute` function now checks whether the campaign has ended before accepting any funds.
- A `refund` function, which allows donors to get their donations back if the fundraising goal wasn't met by the deadline. This function will check if the campaign has ended and whether the goal was met. It then verifies that the sender has contributed to the campaign, sets their contribution to zero, and then sends them back their original contribution.

*Please note, you need to make sure you have a reliable and secure way of validating and fulfilling the contracts in real life. Smart contracts are best used when complemented with a solid legal framework. Also, this is a simplified example and lacks many important features such as refunding donors if the goal isn't met, security features, dispute resolution mechanisms, etc.*

## Development Resources

### Other Repositories

#### Block Foundation Smart Contract Series

|                                   | `Solidity`  | `Teal`      |
| --------------------------------- | ----------- | ----------- |
| **Template**                      | [**>>>**](https://github.com/block-foundation/solidity-template) | [**>>>**](https://github.com/block-foundation/teal-template) |
| **Architectural Design**          | [**>>>**](https://github.com/block-foundation/solidity-architectural-design) | [**>>>**](https://github.com/block-foundation/teal-architectural-design) |
| **Architecture Competition**      | [**>>>**](https://github.com/block-foundation/solidity-architecture-competition) | [**>>>**](https://github.com/block-foundation/teal-architecture-competition) |
| **Housing Cooporative**           | [**>>>**](https://github.com/block-foundation/solidity-housing-cooperative) | [**>>>**](https://github.com/block-foundation/teal-housing-cooperative) |
| **Land Registry**                 | [**>>>**](https://github.com/block-foundation/solidity-land-registry) | [**>>>**](https://github.com/block-foundation/teal-land-registry) |
| **Real-Estate Crowdfunding**      | [**>>>**](https://github.com/block-foundation/solidity-real-estate-crowdfunding) | [**>>>**](https://github.com/block-foundation/teal-real-estate-crowdfunding) |
| **Rent-to-Own**                   | [**>>>**](https://github.com/block-foundation/solidity-rent-to-own) | [**>>>**](https://github.com/block-foundation/teal-rent-to-own) |
| **Self-Owning Building**          | [**>>>**](https://github.com/block-foundation/solidity-self-owning-building) | [**>>>**](https://github.com/block-foundation/teal-self-owning-building) |
| **Smart Home**                    | [**>>>**](https://github.com/block-foundation/solidity-smart-home) | [**>>>**](https://github.com/block-foundation/teal-smart-home) |

## Legal Information

### Copyright

Copyright 2023, [Stichting Block Foundation](https://www.blockfoundation.io). All rights reserved.

### License

Except as otherwise noted, the content in this repository is licensed under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/), and
code samples are licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).

Also see [LICENSE](https://github.com/block-foundation/community/blob/master/LICENSE) and [LICENSE-CODE](https://github.com/block-foundation/community/blob/master/LICENSE-CODE).

### Warning

**Please note that this code should be audited by a professional smart-contract auditor before being used in a production environment as it is a simplified example and may not cover all potential security vulnerabilities.**

### Disclaimer

**THIS SOFTWARE IS PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
