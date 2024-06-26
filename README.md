# Degen Tokens for gaming

In this project we have created a token named DEGEN token for the gamers and gaming society and there different functions like mint, burn, transfer, Checking balance and redeem points. In this program we have used Hardhat , Nodejs, solidity and metamask for our project configuration.

## Description

So this program conssit of smart contract Points.sol in which we have written a Tokenn contract importing the ERC20 contracts from openzeppelin and we provide unctions like mint, burn, transfer, check_balance and redeeming points for items or swags available. We have used node js and hardhat for deployment and verification of the contracts. We deploy this contract on avalanche fuji testnet chain using hardhat and deploy.js file in fuji c chain. for every transaction we perform on this contract it will be refleced on snowtrace(testnet). 
## Getting Started

### Installing
```
cd {your project)
npm init -y
```
### Executing program

* Run these two commands to create and initialize npm to create package.json in it.
  
```
mkdir project
cd project
npm init -y
```

* Now create a hardhat configuratin file using.

```
npx hardhat
```
* Choose create js file. It will create configuration file.
* Now do some settings in your configuration file. Add fuji testnet to configuration.
```
require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = true;
let forkingData = undefined;
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData,
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [PRIVATE_KEY], // we use a .env file to hide our wallets private key
    },
    mainnet: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: placeholder, // we use an .env file to hide our Snowtrace API KEY
  },
};
```

* Now create a folder contracts and a folder scripts.
* In Contracts file create a new solidity file and write your contract in that.
  
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Tokenn is ERC20 {
    constructor() ERC20("DEGEN", "DGN") {
        
    }
    address owner=msg.sender;
    modifier mint_by_owner(){
      require(msg.sender==owner,"Minting allowed to owner only");
      _;
    }
    function mint(address recieve, uint amount)public mint_by_owner{
      _mint(recieve,amount);
    }
    function burn(address account,uint amount)public{
      require(balanceOf(msg.sender)>=amount && msg.sender==account,"Not enough balance");
      _burn(account, amount);
    }
    function transfer(address send,address rec,uint amount) public{
      require(balanceOf(msg.sender)>=amount && msg.sender==send ,"Not enough balance");
      _transfer(send, rec, amount);
    }
    function check_balance(address account) external view returns(uint256){
      return this.balanceOf(account);
    }
    function redeem_points(address account,uint items) public {
      require(balanceOf(msg.sender)>=(items*5) && msg.sender==account,"Not enough balance");
      _burn(account,(items*5) );

    }
    function decimals() override public pure returns(uint8){
      return 0;
    }

}

```

* Now add deploy.js to scripts folder.

```
const hre = require("hardhat");

async function main() {
  // Get the Points smart contract
  const Degen = await hre.ethers.getContractFactory("Tokenn");

  // Deploy it
  const degen = await Degen.deploy();
  await degen.deployed();

  // Display the contract address
  console.log(`Degen token deployed to ${degen.address}`);
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

 * Now deploy your contract and verify with these two commands.
   
```
$ npx hardhat run scripts/deploy.js --network fuji
Output: Points token deployed to <YOUR TOKEN ADDRESS>
$ npx hardhat verify <YOUR TOKEN ADDRESS> --network fuji
```

## Authors

Contributors names and contact info

Hardik
hardikxibscience238@gmail.com
