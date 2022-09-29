// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you"ll find the Hardhat
// Runtime Environment"s members available in the global scope.
const hre = require("hardhat")

async function main() {
  await hre.run("compile")

  // We get the contract to deploy
  const SimpleStorage = await hre.ethers.getContractFactory("SimpleStorage")
  const simpleStorage = await SimpleStorage.deploy()
  await simpleStorage.deployed()
  const transactionResponse = await simpleStorage.store(1)
  const transactionReceipt = await transactionResponse.wait()
  console.log("Event: ", transactionReceipt.events[0])
  console.log("Old favoriteNumber: ", transactionReceipt.events[0].args.oldNumber.toString())
  console.log("New favoriteNumber: ", transactionReceipt.events[0].args.newNumber.toString())
  console.log("Added favoriteNumber: ", transactionReceipt.events[0].args.addedNumber.toString())
  console.log("User who called the 'store' function: ", transactionReceipt.events[0].args.sender)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
