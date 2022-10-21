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

  describe('Deposit', function () {
    it('Should deposit Ether to the contract', async function () {
      const { etherWallet } = await loadFixture(deployFixture)

      const tx = await etherWallet.deposit({
        value: ethers.utils.parseEther('1'),
      })
      await tx.wait()

      const balance = await ethers.provider.getBalance(etherWallet.address)
      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('Check Balance', function () {
    it('Should check default balance of the EtherWallet contract', async function () {
      const { etherWallet } = await loadFixture(deployFixture)

      const balance = await etherWallet.balanceOf()

      expect(balance.toString()).to.equal(ethers.utils.parseEther('0'))
    })

    it('Should check balance of the EtherWallet contract after depositing some Ether', async function () {
      const { etherWallet } = await loadFixture(deployFixture)

      const tx = await etherWallet.deposit({
        value: ethers.utils.parseEther('1'),
      })
      await tx.wait()

      const balance = await etherWallet.balanceOf()

      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('Withdraw', function () {
    it('Should withdraw ether from the contract with zero ETH(Not a very useful test)', async function () {
      const { etherWallet, owner } = await loadFixture(deployFixture)

      const tx = await etherWallet
        .connect(owner)
        .withdraw(owner.address, ethers.utils.parseEther('0'))
      await tx.wait()

      const balance = await ethers.provider.getBalance(etherWallet.address)
      expect(balance.toString()).to.equal(ethers.utils.parseEther('0'))
    })

    it('Should withdraw ether from the contract with non-zero ETH', async function () {
      const { etherWallet, owner } = await loadFixture(deployFixture)

      // Let's first deposit some Ether to the contract so can withdraw later
      const depositTx = await etherWallet.deposit({
        value: ethers.utils.parseEther('1'),
      })
      await depositTx.wait()
      let balance = await ethers.provider.getBalance(etherWallet.address)
      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))

      // Let's now execute our withdraw function
      const withdrawTx = await etherWallet.withdraw(
        owner.address,
        ethers.utils.parseEther('1')
      )
      await withdrawTx.wait()

      balance = await ethers.provider.getBalance(etherWallet.address)
      expect(balance.toString()).to.equal(ethers.utils.parseEther('0'))
    })

    it('Should revert the tx when withdraw is called by someone other than the owner', async function () {
      const { etherWallet, otherAccount } = await loadFixture(deployFixture)

      await expect(
        etherWallet
          .connect(otherAccount)
          .withdraw(otherAccount.address, ethers.utils.parseEther('0'))
      ).to.be.revertedWith('Only owner can withdraw the Ether')
    })
  })
})
