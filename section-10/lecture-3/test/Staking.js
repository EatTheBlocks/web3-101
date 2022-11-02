const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('EtherWallet', function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    // Contracts are deployed using the first signer/account by default
    const [user1, user2] = await ethers.getSigners()

    const Staking = await hre.ethers.getContractFactory('Staking')
    const staking = await Staking.deploy()

    return { staking, user1, user2 }
  }

  async function helperCreateWallet(staking) {
    const tx = await staking.walletCreate()
    await tx.wait()
  }

  async function helperGetWallet(staking, index) {
    const stakeWallets = await staking.getWallets()
    return stakeWallets[index]
  }

  async function helperMineNBlocks(n) {
    for (let index = 0; index < n; index++) {
      await ethers.provider.send('evm_mine')
    }
  }

  describe('walletCreate', function () {
    it('Should create a wallet', async function () {
      const { user1, staking } = await loadFixture(deployFixture)

      const tx = await staking.walletCreate()
      await tx.wait()

      const stakeWallets = await staking.getWallets()
      const stakeWallet = stakeWallets[0]

      expect(stakeWallet.user).to.not.be.empty
      expect(stakeWallet.owner).to.equal(user1.address)
    })
  })

  describe('walletDeposit', function () {
    it('Should deposit Ether to the Wallet contract', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const tx = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      tx.wait()

      // Fetch the first wallet
      const wallet = await helperGetWallet(staking, 0)

      // Check for the result
      const balance = await ethers.provider.getBalance(wallet.user)

      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('stakeEth', function () {
    it('Should stake Ether to the staking contract', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const tx = await staking.stakeEth(0)
      tx.wait()

      // Fetch the first wallet
      const wallet = await helperGetWallet(staking, 0)

      expect(
        (await ethers.provider.getBalance(wallet.user)).toString()
      ).to.equal(ethers.utils.parseEther('0'))
      expect(wallet.amount.toString()).to.equal(ethers.utils.parseEther('1'))
      expect(wallet.sinceBlock).to.not.be.empty
    })
  })

  describe('currentStake', function () {
    it('Should return the current stake', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const txStake = await staking.stakeEth(0)
      txStake.wait()

      // Fetch the first wallet
      const wallet = await helperGetWallet(staking, 0)

      // Get the current stake
      const balance = await staking.currentStake(0)

      expect(
        (await ethers.provider.getBalance(wallet.user)).toString()
      ).to.equal(ethers.utils.parseEther('0'))
      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('unstakeEth', function () {
    it('Should unstake Ether from the staking contract', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const txStake = await staking.stakeEth(0)
      txStake.wait()

      // Fetch the first wallet
      let wallet = await helperGetWallet(staking, 0)

      expect(
        (await ethers.provider.getBalance(wallet.user)).toString()
      ).to.equal(ethers.utils.parseEther('0'))
      expect(wallet.amount.toString()).to.equal(ethers.utils.parseEther('1'))
      expect(wallet.sinceBlock).to.not.be.empty

      // Unstake ETH
      const tx = await staking.unstakeEth(0)
      tx.wait()

      // Refetch the first wallet
      wallet = await helperGetWallet(staking, 0)

      expect(
        (await ethers.provider.getBalance(wallet.user)).toString()
      ).to.equal(ethers.utils.parseEther('1'))
      expect(wallet.amount.toString()).to.equal(ethers.utils.parseEther('0'))
      expect(wallet.sinceBlock.toString()).to.equal(
        ethers.utils.parseEther('0')
      )
      expect(wallet.untilBlock).to.not.be.empty
    })
  })

  describe('walletWithdraw', function () {
    it('Should withdraw Ether from the Wallet contract', async function () {
      const { user1, staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Fetch the first wallet
      let wallet = await helperGetWallet(staking, 0)

      // Check for the result
      let balance = await ethers.provider.getBalance(wallet.user)

      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))

      // Withdraw ETH
      const tx = await staking.walletWithdraw(
        0,
        user1.address,
        ethers.utils.parseEther('1')
      )
      tx.wait()

      // Check for the result
      balance = await ethers.provider.getBalance(wallet.user)

      expect(balance.toString()).to.equal(ethers.utils.parseEther('0'))
    })
  })

  describe('walletBalance', function () {
    it('Should check the current balance of the wallet', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const tx = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      tx.wait()

      // Check for the balance
      const balance = await staking.walletBalance(0)

      expect(balance.toString()).to.equal(ethers.utils.parseEther('1'))
    })
  })

  describe('currentReward', function () {
    it('Should get the current staking reward for a wallet', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const txStake = await staking.stakeEth(0)
      txStake.wait()

      // Mine 2 blocks as a simulation
      await helperMineNBlocks(2)

      // Get the current reward
      const reward = await staking.currentReward(0)

      expect(reward.toString()).to.equal(ethers.utils.parseEther('0.02')) // This is equivalent to getting rewarded with 1% per block which is our reward formula
    })
  })

  describe('totalAddressesStaked', function () {
    it('Should get the total number of addresses that have staked in the pool', async function () {
      const { staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const txStake = await staking.stakeEth(0)
      txStake.wait()

      // Check for the result
      const numAddressesStaked = await staking.totalAddressesStaked()

      expect(numAddressesStaked).to.equal(1)
    })
  })

  describe('isWalletStaked', function () {
    it('Check if a particular address has staked in the pool', async function () {
      const { user1, staking } = await loadFixture(deployFixture)

      // Create a wallet first
      await helperCreateWallet(staking)

      // Deposit some ETH
      const txDeposit = await staking.walletDeposit(0, {
        value: ethers.utils.parseEther('1'),
      })
      txDeposit.wait()

      // Stake ETH
      const txStake = await staking.stakeEth(0)
      txStake.wait()

      // Check for the result
      const found = await staking.isWalletStaked(0)

      expect(found).to.be.true
    })
  })
})
