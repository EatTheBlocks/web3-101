require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  paths: {
    sources: './contracts',
    artifacts: './src/artifacts'
  },
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      chainID: 1337
    },
    goerli: {
      url: 'https://goerli-testnet-node-url.com',
      // accounts: [privateKey1, privateKey2]
    }
  }
};
