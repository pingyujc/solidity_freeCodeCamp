// should deploy the solidity contract

// use async function so that we can wait for the contract to be deployed first before moving on

const ethers = require("ethers");
const fs = require("fs"); // use this to read Abi and Bin

async function main() {
  // ganache fake blockchain
  // http://127.0.0.1:7545
  // this line connects to the blockchain
  const provider = new ethers.providers.JsonRpcProvider(
    "http://127.0.0.1:7545"
  );

  // this line connects the wallet
  // need to provide the private key and the provider
  const wallet = new ethers.Wallet(
    "0xfc0863e7a7bb7102dd2c371fd6390e13e5d228b4b8432bf7ea2c87495d897210",
    provider
  );

  // reading Abi and Bin
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  // contract factory is used to deplot contract
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying...");

  // setting a manual gas limit
  let gasLimit = 3000000;
  const contract = await contractFactory.deploy();
  // STOP here and wait for the contract to be deploy
  console.log("DONE");
  // console.log(contract);
  const deploymentReceipt = await contract.deployTransaction.wait(1);
  console.log(deploymentReceipt);
}

// calling the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
