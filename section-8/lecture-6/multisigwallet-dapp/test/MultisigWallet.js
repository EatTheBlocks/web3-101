const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('EtherWallet', function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner1, owner2, owner3] = await ethers.getSigners()
    const quorumRequired = 2

    const MultisigWallet = await ethers.getContractFactory('MultisigWallet')
    const multisigWallet = await MultisigWallet.deploy(
      [owner1.address, owner2.address, owner3.address],
      quorumRequired
    )

    return { multisigWallet, owner1, owner2, owner3 }
  }

  describe('Deployment', function () {
    it('Should deploy and set the owners and quorum', async function () {
      const { multisigWallet, owner1, owner2, owner3 } = await loadFixture(
        deployFixture
      )

      expect(await multisigWallet.getOwners()).to.have.same.deep.members([
        owner1.address,
        owner2.address,
        owner3.address,
      ])
      expect(await multisigWallet.quorumRequired()).to.equal(2)
    })
  })

  describe('Deposit', function () {
    it('Should deposit Ether to the contract', async function () {
      const { multisigWallet } = await loadFixture(deployFixture)

      const tx = await multisigWallet.deposit({
        value: ethers.utils.parseEther('1'),
      })
      await tx.wait()

      const balance = await ethers.provider.getBalance(multisigWallet.address)
      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('Withdraw', function () {
    it('Should withdraw ether from the contract', async function () {})
  })
})
