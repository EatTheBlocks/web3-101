// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require('hardhat')

async function main() {
  const [owner1, owner2, owner3] = await hre.ethers.getSigners()
  const quorumRequired = 2

  const MultisigWallet = await hre.ethers.getContractFactory('MultisigWallet')
  const multisigWallet = await MultisigWallet.deploy(
    [owner1.address, owner2.address, owner3.address],
    quorumRequired
  )

  await multisigWallet.deployed()

  console.log(`Multisig Wallet Contract deployed to ${multisigWallet.address}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
