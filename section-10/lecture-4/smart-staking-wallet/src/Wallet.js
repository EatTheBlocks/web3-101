import { useContract, useQuery } from 'wagmi'

import Staking from './artifacts/contracts/Staking.sol/Staking.json'

function Wallet({ wallets }) {
  const contract = useContract({
    address: '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0',
    abi: Staking.abi,
  })

  const { data } = useQuery('wallet', async () => {
    let result = []

    return result
  })
  return <></>
}

export default Wallet
