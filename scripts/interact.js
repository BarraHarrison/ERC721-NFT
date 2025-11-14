const hre = require("hardhat");

async function main() {
    const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
    const [owner, addr1] = await hre.ethers.getSigners();

    const MyNFT = await hre.ethers.getContractFactory("MyNFT");
    const myNFT = MyNFT.attach(CONTRACT_ADDRESS);

    console.log("Connected to contract at:", CONTRACT_ADDRESS);

    const mintTransaction = await myNFT.connect(owner).mint(
        addr1.address,
        ""
    );

    await mintTransaction.wait();
    console.log("Mint Transaction complete!");


}