require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

const { ALCHEMY_API_KEY, PRIVATE_KEY } = process.env || {};

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    // example config for Sepolia or Mumbai (uncomment & set env variables to use)
    // sepolia: {
    //   url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
    //   accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
    // },
    // mumbai: {
    //   url: `https://polygon-mumbai.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
    //   accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
    // }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY || ""
  }
};
