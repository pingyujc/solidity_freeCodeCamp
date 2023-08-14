// encrypted the keys to protect the private keys

require("dotenv").config();
const ethers = require("ethers");
const fs = require("fs-extra"); // use this to read Abi and Bin
async function main() {
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY);
  const encryptedJsonKey = await wallet.encrypt(
    process.env.PRIVATE_KEY_PASSWORD,
    process.env.PRIVATE_KEY
  );
  console.log(encryptedJsonKey);
  fs.writeFileSync("./encryptedKey.json", encryptedJsonKey);
}

// calling the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
