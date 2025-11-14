async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with account:", deployer.address);

    const MyNFT = await ethers.getContractFactory("MyNFT");
    const baseURI = "https://example.com/metadata/";
    const myNFT = await MyNFT.deploy("MyNFT", "MNFT", baseURI);

    await myNFT.dpeloyed();
    console.log("MyNFT deployed to:", myNFT.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});