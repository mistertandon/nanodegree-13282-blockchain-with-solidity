const hre = require("hardhat");
async function main() {
  console.log("Deplyment status:: START");
  const DecentralizedMarketplace = await hre.ethers.getContractFactory(
    "DecentralizedMarketplace"
  );
  const decentralizedMarketplace = await DecentralizedMarketplace.deploy();
  console.log(
    "decentralizedMarketplace deployed to : ",
    JSON.stringify(decentralizedMarketplace)
  );
  console.log("Deplyment status:: START::SUCCESS");
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.error("An error occurred during deployment: ", error);
    console.log("Deplyment status:: START::FAIL");
    process.exit(1);
  });
