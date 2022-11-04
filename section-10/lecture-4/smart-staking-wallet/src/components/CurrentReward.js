import { useEffect, useState } from 'react'

import { useContractRead } from 'wagmi'

import { ethers } from 'ethers'

import Button from 'react-bootstrap/Button'

function CurrentReward(props) {
  const [stakeReward, setStakeReward] = useState(0)

  /*
  Note that because the smart contract function currentReward compares the timestamp
  of the current block with the wallet.sinceBlock value, the reward will always
  be the same when testing with hardhat network with default configuration 
  as nothing gets mined automatically there.
  To refresh the reward, you need to mine a block first. This can be done in numerous ways
  - Deposit ETH to wallet
  - Stake ETH to the staking pool
  - Unstake ETH from the staking pool
  - Withdraw ETH from wallet
  Any action that mines a new block will automatically refresh the current reward. This will work 
  just fine if you're working with testnet/mainnet since blocks are mined automatically
  You can also enable generation of a new block every 5 seconds by changing your hardhat config file by adding the following
  hardhat: {
    mining: {
      auto: true,
      interval: 5000
    }
  }
  This will generate a new block every 5 seconds
  */

  // Get current rewards accumulated so far
  const { data: dataStakeReward } = useContractRead({
    ...props.stakingWalletContract,
    functionName: 'currentReward',
    args: [props.walletId],
  })

  // Refresh the reward with the button
  const refreshReward = async () => {
    const result = await props.contract.currentReward(props.walletId)
    setStakeReward(ethers.utils.formatEther(result))
  }

  useEffect(() => {
    if (dataStakeReward) {
      const result = ethers.utils.formatEther(dataStakeReward)
      setStakeReward(result)
    }
  }, [dataStakeReward])

  return (
    <>
      {stakeReward} WEB3{' '}
      <Button variant='info' onClick={refreshReward}>
        Refresh
      </Button>
    </>
  )
}

export default CurrentReward
