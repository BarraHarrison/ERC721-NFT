const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contract with account:", deployer.address);

    const MyNFT = await hre.ethers.getContractFactory("MyNFT");

    const name = "My NFT";
    const symbol = "MNFT";
    const baseURI = "https://example.com/metadata/";

    const myNFT = await MyNFT.deploy(name, symbol, baseURI);

    await myNFT.waitForDeployment();

    console.log("MyNFT deployed to:", await myNFT.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
