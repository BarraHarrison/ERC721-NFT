# Project Overview

This project demonstrates a fully functional ERC-721 NFT smart contract built with Solidity and deployed using Hardhat. The project includes local hosting of metadata and images, on-chain minting of NFTs, and interaction with the deployed contract using Hardhat scripts. The goal was to understand the full workflow of creating, deploying, and minting an NFT using a custom ERC-721 contract.

# Directory Structure

```
erc721_NFT/
├── assets/                 # Contains image files (ignored in .gitignore)
├── contracts/
│   └── MyNFT.sol           # Custom ERC-721 NFT smart contract
├── metadata/
│   └── my-nft.json         # Metadata served to the NFT contract
├── scripts/
│   ├── deploy.js           # Deploys the NFT contract
│   └── interact.js         # Mints NFTs and fetches token URIs
├── server/
│   └── server.js           # Local metadata hosting server (Node.js + Express)
├── hardhat.config.js
└── package.json
```

# How the Metadata Is Hosted

Metadata is hosted locally using a lightweight Node.js Express server. The server serves files from the `/metadata` directory, allowing the ERC-721 contract to fetch metadata using a `tokenURI` that resolves to:

```
http://localhost:3000/metadata/my-nft.json
```

The server is started with:

```
node server/server.js
```

Once running, visiting the metadata URL in the browser confirms the metadata is accessible.

# How the NFT Was Minted

The NFT was minted using the Hardhat `interact.js` script. The script:

1. Connects to the deployed contract
2. Calls the `mint()` function on the ERC-721 contract
3. Sends the NFT to a second address on the local Hardhat blockchain
4. Fetches the `tokenURI` to confirm that metadata resolves correctly

The minting call in the script:

```js
const mintTransaction = await myNFT.connect(owner).mint(
    addr1.address,
    "my-nft"  // tokenId mapped to "my-nft.json"
);
```

The metadata's `image` field points to the hosted image inside the `/assets` directory.

# Output From the Terminal (Mint Transaction Complete)

```
Connected to contract at: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Contract owner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Minting NFT to: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
Mint Transaction complete!
TokenURI for tokenId 1: http://localhost:3000/metadata/my-nft.json
```

This confirms that:

* The script successfully interacted with the contract
* The NFT was minted and sent to another address
* The token metadata is accessible from the local server

# Explanations of What Each Step Means

### **1. Deploying the Contract**

Using Hardhat, the ERC-721 contract is compiled and deployed to a local Hardhat blockchain. This gives the project a real environment to test contract interactions.

### **2. Hosting Metadata Locally**

NFTs rely on metadata to display images and traits. By hosting metadata locally, you simulate how IPFS or cloud hosting would work in real-world deployments.

### **3. Minting the NFT**

The interact script gives the contract owner the ability to mint NFTs to any address. Minting creates a new token on the blockchain and assigns it a metadata URI.

### **4. Reading the TokenURI**

After minting, the script fetches the token’s `tokenURI` from the contract. This verifies that the metadata is correctly linked and can be displayed.

Together, these steps complete a true end-to-end NFT creation workflow—from smart contract creation, to metadata hosting, to minting, and final verification.
