require('@nomicfoundation/hardhat-toolbox')

const { task } = require('hardhat/config')

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task(
  'accounts',
  'Prints the list of accounts and their balances',
  async (taskArgs, hre) => {
    const accounts = await hre.ethers.getSigners()

    for (const account of accounts) {
      const balance = await account.getBalance()
      console.log(account.address, ': ', balance)
    }
  }
)

// Replace this private key with your Goerli account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const PRIVATE_KEY = 'private_key'
const ALCHEMY_KEY = 'alchemy_key'

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: '0.8.17',
  paths: {
    sources: './contracts',
    artifacts: './src/artifacts',
  },
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      chainID: 1337,
      // Enable/Disable this based on your preferences. Check src/components/CurrentReward.js for more info
      /*
        We are going to generate a new block every 5 seconds to simulate real environment while
        testing. We need to do this so we can see our current staked rewards in the frontend.
        If you don't have this, your reward will not be updated.
      */
      // UNCOMMENT THE FOLLOWING LINES IF YOU WANT TO AUTOMINE ON YOUR LOCAL HARDHAT NETWORK every 5 seconds
      /*
      mining: {
        auto: true,
        interval: 5000,
      },
      */
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_KEY}`,
      // TODO: Uncomment the below line after updating PRIVATE_KEY above
      // accounts: [PRIVATE_KEY],
    },
  },
}
