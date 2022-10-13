import { ConnectButton } from '@rainbow-me/rainbowkit'

import { ethers } from 'ethers'
import { useEffect, useState } from 'react'
import Button from 'react-bootstrap/Button'
import Form from 'react-bootstrap/Form'
import Table from 'react-bootstrap/Table'
import { useContract, useContractRead, useSigner } from 'wagmi'
import MultisigWallet from './artifacts/contracts/MultisigWallet.sol/MultisigWallet.json'

function App() {
  const multisigWalletContract = {
    addressOrName: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
    contractInterface: MultisigWallet.abi,
  }

  // MultisigWallet Smart contract handling
  const [scBalance, setScBalance] = useState(0)
  const [scPendingTransactions, setScPendingTransactions] = useState([])
  const [scTotalTransactionCount, setScTotalTransactionCount] = useState(0)
  const [ethToUseForDeposit, setEthToUseForDeposit] = useState(0)
  const [ethToUseForWithdrawal, setEthToUseForWithdrawal] = useState(0)
  const [ethAddrToUseForWithdrawal, setEthAddrToUseForWithdrawal] = useState(0)

  // Get the list of owners of the multisig
  const { data: scOwners } = useContractRead({
    ...multisigWalletContract,
    functionName: 'getOwners',
  })
  // Get the total number of withdraw transactions
  const { data: withdrawTxCount } = useContractRead({
    ...multisigWalletContract,
    functionName: 'getWithdrawTxCount',
    watch: true,
  })
  // Get the current balance of the multisig wallet
  const { data: contractBalance } = useContractRead({
    ...multisigWalletContract,
    functionName: 'balanceOf',
    watch: true,
  })
  // Get the list of transactions
  const { data: withdrawTxes } = useContractRead({
    ...multisigWalletContract,
    functionName: 'getWithdrawTxes',
    watch: true,
  })

  useEffect(() => {
    if (contractBalance) {
      let temp = contractBalance / 10 ** 18
      setScBalance(temp)
    }
    setScTotalTransactionCount(withdrawTxCount.toNumber())
    let pendingTxes = []
    for (let i = 0; i <= withdrawTxes.length - 1; i++) {
      if (!withdrawTxes[i][3]) {
        pendingTxes.push({
          transactionIndex: i,
          to: withdrawTxes[i][0],
          amount: parseInt(ethers.utils.formatEther(withdrawTxes[i][1])),
          approvals: withdrawTxes[i][2].toNumber(),
        })
      }
    }
    setScPendingTransactions(pendingTxes)
  }, [contractBalance, withdrawTxCount, withdrawTxes])

  const { data: signer } = useSigner()
  const contract = useContract({
    ...multisigWalletContract,
    signerOrProvider: signer,
  })

  // Deposit ETH to the MultisigWallet smart contract
  const depositToEtherWalletContract = async () => {
    await contract.deposit({
      value: ethers.utils.parseEther(ethToUseForDeposit),
    })
  }
  // Create Withdraw ETH tx in the MultisigWallet smart contract
  const withdrawFromEtherWalletContract = async () => {
    await contract.createWithdrawTx(
      ethAddrToUseForWithdrawal,
      ethers.utils.parseEther(ethToUseForWithdrawal)
    )
  }
  // Approve pending withdraw tx in the MultisigWallet smart contract
  const approvePendingTransaction = async (transactionIndex) => {
    await contract.approveWithdrawTx(transactionIndex)
  }

  return (
    <div className='container flex flex-col  items-center mt-10'>
      <div className='flex mb-6'>
        <ConnectButton />
      </div>

      <h3 className='text-5xl font-bold mb-20'>{'Multisig Wallet Info'}</h3>
      <div>
        EtherWallet Smart Contract Address:{' '}
        {multisigWalletContract.addressOrName}
      </div>
      <div>EtherWallet Smart Contract Balance: {scBalance} ETH</div>
      <div>EtherWallet Smart Contract Owners:</div>
      <ul>
        {scOwners.map((scOwner, i) => {
          return <li key={i}>{scOwner}</li>
        })}
      </ul>
      <div>
        EtherWallet Smart Contract Total Transactions: {scTotalTransactionCount}
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

      <h3 className='text-5xl font-bold mb-20'>
        {'Withdraw from EtherWallet Smart Contract'}
      </h3>
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

      <h3 className='text-5xl font-bold mb-20'>
        {'Pending Withdraw Transactions'}
      </h3>
      <Table striped hover>
        <thead>
          <tr>
            <th>#</th>
            <th>Receiver</th>
            <th>Amount</th>
            <th>Number of Approvals</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {scPendingTransactions.map((tx, i) => {
            return (
              <tr key={i}>
                <td>{i}</td>
                <td>{tx.to}</td>
                <td>{tx.amount} ETH</td>
                <td>{tx.approvals}</td>
                <td>
                  <Button
                    variant='success'
                    onClick={() =>
                      approvePendingTransaction(tx.transactionIndex)
                    }
                  >
                    Approve
                  </Button>
                </td>
              </tr>
            )
          })}
        </tbody>
      </Table>
    </div>
  )
}

export default App
