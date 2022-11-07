const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const { ethers } = require('hardhat')
const { PANIC_CODES } = require('@nomicfoundation/hardhat-chai-matchers/panic')

describe('EtherWallet', function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner1, owner2, owner3, otherAccount] = await ethers.getSigners()
    const quorumRequired = 2

    const MultisigWallet = await ethers.getContractFactory('MultisigWallet')
    const multisigWallet = await MultisigWallet.deploy(
      [owner1.address, owner2.address, owner3.address],
      quorumRequired
    )

    return { multisigWallet, owner1, owner2, owner3, otherAccount }
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

  describe('Check Balance', function () {
    it('Should check default balance of the MultisigWallet contract', async function () {
      const { multisigWallet } = await loadFixture(deployFixture)

      const balance = await multisigWallet.balanceOf()

      expect(balance.toString()).to.equal(ethers.utils.parseEther('0'))
    })

    it('Should check balance of the MultisigWallet contract after depositing some Ether', async function () {
      const { multisigWallet } = await loadFixture(deployFixture)

      const tx = await multisigWallet.deposit({
        value: ethers.utils.parseEther('1'),
      })
      await tx.wait()

      const balance = await multisigWallet.balanceOf()

      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('Withdraw', function () {
    it('Should create withdraw transaction', async function () {
      const { multisigWallet, owner1 } = await loadFixture(deployFixture)

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      // Let's check the array 'withdrawTxes'
      const withdrawTxes = await multisigWallet.getWithdrawTxes()
      const actualTx = withdrawTxes[0]

      expect(actualTx.to).to.equal(owner1.address)
      expect(actualTx.amount).to.equal(ethers.utils.parseEther('0'))
      expect(actualTx.approvals).to.equal(0)
      expect(actualTx.sent).to.equal(false)
    })

    it('Should revert the tx when withdraw is called by someone other than the owner', async function () {
      const { multisigWallet, otherAccount } = await loadFixture(deployFixture)

      await expect(
        multisigWallet
          .connect(otherAccount)
          .createWithdrawTx(otherAccount.address, ethers.utils.parseEther('0'))
      ).to.be.revertedWith('not owner')
    })
  })

  describe('Approve Withdraw transaction', function () {
    it('Should approve existing withdraw transaction', async function () {
      const { multisigWallet, owner1 } = await loadFixture(deployFixture)

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      // Let's now execute our approve function
      const approveTx = await multisigWallet.approveWithdrawTx(0)
      await approveTx.wait()

      // Let's check the array 'withdrawTxes'
      const withdrawTxes = await multisigWallet.getWithdrawTxes()
      const actualTx = withdrawTxes[0]

      expect(actualTx.to).to.equal(owner1.address)
      expect(actualTx.amount).to.equal(ethers.utils.parseEther('0'))
      expect(actualTx.approvals).to.equal(1) // This should be 1 since we just approved
      expect(actualTx.sent).to.equal(false)
    })

    it('Should send the existing withdraw transaction after majority approval', async function () {
      const { multisigWallet, owner1, owner2, owner3 } = await loadFixture(
        deployFixture
      )

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      // Let's now execute our approve function from owner1. note that this is the default behavior
      let approveTx = await multisigWallet.approveWithdrawTx(0)
      await approveTx.wait()
      // Let's now execute our approve function from owner2
      approveTx = await multisigWallet.connect(owner2).approveWithdrawTx(0)
      await approveTx.wait()

      // Let's check the array 'withdrawTxes'
      const withdrawTxes = await multisigWallet.getWithdrawTxes()
      const actualTx = withdrawTxes[0]

      expect(actualTx.to).to.equal(owner1.address)
      expect(actualTx.amount).to.equal(ethers.utils.parseEther('0'))
      expect(actualTx.approvals).to.equal(2) // This should be 2 since we had two owners approve this transaction
      expect(actualTx.sent).to.equal(true) // This should be true since we got approvals from at least two owners
    })

    it('Should revert the tx when approve is called by someone other than the owner', async function () {
      const { multisigWallet, owner1, otherAccount } = await loadFixture(
        deployFixture
      )

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      await expect(
        multisigWallet.connect(otherAccount).approveWithdrawTx(0)
      ).to.be.revertedWith('not owner')
    })

    it('Should revert the tx when approve is called for a transaction that does not exist', async function () {
      const { multisigWallet, owner1 } = await loadFixture(deployFixture)

      await expect(
        multisigWallet.connect(owner1).approveWithdrawTx(0)
      ).to.be.revertedWithPanic(PANIC_CODES.ARRAY_ACCESS_OUT_OF_BOUNDS)
    })

    it('Should revert the tx when approve is called for a transaction that has already been approved by the caller', async function () {
      const { multisigWallet, owner1 } = await loadFixture(deployFixture)

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      // Let's now execute our approve function
      const approveTx = await multisigWallet.approveWithdrawTx(0)
      await approveTx.wait()

      await expect(
        multisigWallet.connect(owner1).approveWithdrawTx(0)
      ).to.be.revertedWithCustomError(multisigWallet, 'TxAlreadyApproved')
    })

    it('Should revert the tx when approve is called for a transaction that has already been sent', async function () {
      const { multisigWallet, owner1, owner2, owner3 } = await loadFixture(
        deployFixture
      )

      // Let's execute our withdraw function
      const withdrawTx = await multisigWallet.createWithdrawTx(
        owner1.address,
        ethers.utils.parseEther('0')
      )
      await withdrawTx.wait()

      // Let's now execute our approve function from owner1. note that this is the default behavior
      let approveTx = await multisigWallet.approveWithdrawTx(0)
      await approveTx.wait()
      // Let's now execute our approve function from owner2
      approveTx = await multisigWallet.connect(owner2).approveWithdrawTx(0)
      await approveTx.wait()

      await expect(
        multisigWallet.connect(owner3).approveWithdrawTx(0)
      ).to.be.revertedWithCustomError(multisigWallet, 'TxAlreadySent')
    })
  })
})
