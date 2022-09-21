const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('EtherWallet', function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners()

    const EtherWallet = await ethers.getContractFactory('EtherWallet')
    const etherWallet = await EtherWallet.deploy()

    return { etherWallet, owner, otherAccount }
  }

  describe('Deployment', function () {
    it('Should deploy and set the owner to be the deployer address', async function () {
      const { etherWallet, owner } = await loadFixture(deployFixture)

      expect(await etherWallet.owner()).to.equal(owner.address)
    })
  })
})
