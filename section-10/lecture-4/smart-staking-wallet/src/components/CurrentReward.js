import { useEffect, useState } from 'react'

import { useContractRead } from 'wagmi'

import { ethers } from 'ethers'

function CurrentReward(props) {
  const [stakeReward, setStakeReward] = useState(0)

  // Get current rewards accumulated so far
  /*
  Note that because the smart contract function currentReward compares the timestamp
  of the current block with the wallet.sinceBlock value, the reward will always
  be the same when testing with hardhat network as nothing gets mined automatically there.
  To refresh the reward, you need to mine a block first. This can be done in numerous ways
  - Deposit ETH to wallet
  - Stake ETH to the staking pool
  - Unstake ETH from the staking pool
  - Withdraw ETH from wallet
  Any action that mines a new block will automatically refresh the current reward. This will work 
  just fine if you're working with testnet/mainnet since blocks are mined automatically
  */
  const { data: dataStakeReward } = useContractRead({
    ...props.stakingWalletContract,
    functionName: 'currentReward',
    args: [props.walletId],
  })

  useEffect(() => {
    if (dataStakeReward) {
      const result = ethers.utils.formatEther(dataStakeReward)
      setStakeReward(result)
    }
  }, [dataStakeReward])

  return <>{stakeReward} WEB3</>
}

export default CurrentReward
