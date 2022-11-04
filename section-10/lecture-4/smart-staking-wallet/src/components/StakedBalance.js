import { useEffect, useState } from 'react'

import { useContractRead } from 'wagmi'

import { ethers } from 'ethers'

function StakedBalance(props) {
  const [balance, setBalance] = useState(0)

  // Get balance of ETH that's staked in the staking pool
  const { data: dataBalance } = useContractRead({
    ...props.stakingWalletContract,
    functionName: 'currentStake',
    watch: true,
    args: [props.walletId],
  })

  useEffect(() => {
    if (dataBalance) {
      const result = ethers.utils.formatEther(dataBalance)
      setBalance(result)
    }
  }, [dataBalance])

  return <>{balance} ETH</>
}

export default StakedBalance
