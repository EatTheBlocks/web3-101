import { ConnectButton } from '@rainbow-me/rainbowkit'

import { ethers } from 'ethers'
import { useEffect, useState } from 'react'
import Button from 'react-bootstrap/Button'
import Form from 'react-bootstrap/Form'
import { useContract, useContractRead, useSigner } from 'wagmi'
import EtherWallet from './artifacts/contracts/EtherWallet.sol/EtherWallet.json'

function App() {
  const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3'

  // EtherWallet Smart contract handling
  const [scBalance, scSetScBalance] = useState(0)
  const [ethToUseForDeposit, setEthToUseForDeposit] = useState(0)
  const [ethToUseForWithdrawal, setEthToUseForWithdrawal] = useState(0)
  const [ethAddrToUseForWithdrawal, setEthAddrToUseForWithdrawal] = useState(
    ethers.constants.AddressZero
  )

  const { data: contractBalance } = useContractRead({
    addressOrName: contractAddress,
    contractInterface: EtherWallet.abi,
    functionName: 'balanceOf',
    watch: true,
  })
  useEffect(() => {
    if (contractBalance) {
      let temp = contractBalance / 10 ** 18
      scSetScBalance(temp)
    }
  }, [contractBalance])

  const { data: signer } = useSigner()
  const contract = useContract({
    addressOrName: contractAddress,
    contractInterface: EtherWallet.abi,
    signerOrProvider: signer,
  })
  // Deposit ETH to the EtherWallet smart contract
  const depositToEtherWalletContract = async () => {
    await contract.deposit({
      value: ethers.utils.parseEther(ethToUseForDeposit),
    })
    setEthToUseForDeposit(0)
  }
  // Withdraw ETH from the EtherWallet smart contract
  const withdrawFromEtherWalletContract = async () => {
    await contract.withdraw(
      ethAddrToUseForWithdrawal,
      ethers.utils.parseEther(ethToUseForWithdrawal)
    )
    setEthToUseForWithdrawal(0)
    setEthAddrToUseForWithdrawal(ethers.constants.AddressZero)
  }

  return (
    <div className='container flex flex-col  items-center mt-10'>
      <div className='flex mb-6'>
        <ConnectButton />
      </div>
      <h3 className='text-5xl font-bold mb-20'>
        {'Deposit to EtherWallet Smart Contract'}
      </h3>

      <Form>
        <Form.Group className='mb-3' controlId='numberInEthDeposit'>
          <Form.Control
            type='text'
            placeholder='Enter the amount in ETH'
            onChange={(e) => setEthToUseForDeposit(e.target.value)}
          />
          <Button variant='primary' onClick={depositToEtherWalletContract}>
            Deposit
          </Button>
        </Form.Group>
      </Form>

      <Form>
        <Form.Group className='mb-3' controlId='numberInEthWithdraw'>
          <Form.Control
            type='text'
            placeholder='Enter the amount in ETH'
            onChange={(e) => setEthToUseForWithdrawal(e.target.value)}
          />
          <Form.Control
            type='text'
            placeholder='Enter the ETH address to withdraw to'
            onChange={(e) => setEthAddrToUseForWithdrawal(e.target.value)}
          />
          <Button variant='primary' onClick={withdrawFromEtherWalletContract}>
            Withdraw
          </Button>
        </Form.Group>
      </Form>

      <div>EtherWallet Smart Contract Address: {contractAddress}</div>
      <div>EtherWallet Smart Contract Balance: {scBalance} ETH</div>
    </div>
  )
}

export default App
