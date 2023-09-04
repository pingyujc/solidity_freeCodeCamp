// imports
const { ethers, run, network } = require("hardhat");

// main
async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
  console.log("Deploying contract...");
  const simpleStorage = await SimpleStorageFactory.deploy();

  // some hardhat update: use waitforDeployment
  await simpleStorage.waitForDeployment();
  // use traget instead of address
  console.log(`Deployed contract to: ${simpleStorage.target}`);
  console.log(network.config);

  // only verify when we are deploying on sepolia
  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    // wait for a few blocks before verifying
    // await simpleStorage.deploymentTransaction.wait(6);
    await verify(simpleStorage.target, []);
  }
}

// auto verification after we deploy
async function verify(contractAddress, args) {
  console.log("Verifying contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (e) {
    console.log(e);
  }
}

// running main
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
