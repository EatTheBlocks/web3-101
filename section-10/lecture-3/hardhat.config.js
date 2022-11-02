require('@nomicfoundation/hardhat-toolbox')

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
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_KEY}`,
      // TODO: Uncomment the below line after updating PRIVATE_KEY above
      // accounts: [PRIVATE_KEY],
    },
  },
}
