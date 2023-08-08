// should deploy the solidity contract

// use async function so that we can wait for the contract to be deployed first before moving on

async function main() {
  console.log("Hello yoo");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
