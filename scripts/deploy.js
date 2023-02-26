const hre = require('hardhat');

// npx hardhat run --network goerli scripts/deploy.js
async function main() {
    const Swap = await hre.ethers.getContractFactory('Swap');
    const token = await Swap.deploy();

    await token.deployed();

    console.log(`Deployed to ${token.address}`);

    await hre.run('verify:verify', {
        address: token.address,
        // see: https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan#using-programmatically
        constructorArguments: [],
    });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
