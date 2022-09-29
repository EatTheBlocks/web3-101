const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers')
const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('SimpleStore', async () => {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployFixture() {
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners()

        const SimpleStorage = await ethers.getContractFactory('SimpleStorage')
        const simpleStorage = await SimpleStorage.deploy()

        return { simpleStorage, owner, otherAccount }
    }

    it('should emit storedNumber event', async () => {
        const { simpleStorage, owner } = await loadFixture(deployFixture)

        const newFavoriteNumber = 1
        const tx = await simpleStorage.store(newFavoriteNumber)
        expect(tx).to.emit(simpleStorage, 'storedNumber')
    })

})
