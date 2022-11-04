import { ConnectButton } from '@rainbow-me/rainbowkit'

import Container from 'react-bootstrap/Container'

import Button from 'react-bootstrap/Button'
import Row from 'react-bootstrap/Row'
import Table from 'react-bootstrap/Table'

import { ethers } from 'ethers'
import { useContract, useContractRead, useSigner } from 'wagmi'

import Staking from './artifacts/contracts/Staking.sol/Staking.json'

import CurrentReward from './components/CurrentReward'
import Deposit from './components/Deposit'
import Stake from './components/Stake'
import StakingPoolInfo from './components/StakingPoolInfo'
import Unstake from './components/Unstake'
import WalletBalance from './components/WalletBalance'
import Withdraw from './components/Withdraw'

function App() {
  const stakingWalletContract = {
    address: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
    abi: Staking.abi,
  }

  // Create a contract instance
  const { data: signer } = useSigner()
  const contract = useContract({
    ...stakingWalletContract,
    signerOrProvider: signer,
  })

  // Create a new wallet
  const walletCreate = async () => {
    await contract.walletCreate()
  }

  // Get the total list of wallets
  const { data: wallets } = useContractRead({
    ...stakingWalletContract,
    functionName: 'getWallets',
    watch: true,
  })

  return (
    <div className='container flex flex-col  items-center mt-10'>
      <div className='flex mb-6'>
        <ConnectButton />
      </div>

      <StakingPoolInfo stakingWalletContract={stakingWalletContract} />

      <br />

      <Container>
        <Row>
          <h3 className='text-5xl font-bold mb-20'>{'My Wallets'}</h3>
        </Row>
        <Row>
          <Table striped bordered hover>
            <thead>
              <tr>
                <th>Wallet Id</th>
                <th>Deposit</th>
                <th>Current Balance</th>

                <th>Withdraw</th>
                <th>Staked?</th>
                <th>Stake</th>
                <th>Current Stake</th>
                <th>Unstake</th>
                <th>Current Staked Rewards</th>
              </tr>
            </thead>
            <tbody>
              {wallets.map((wallet, i) => {
                return (
                  <tr key={i}>
                    <td>{i}</td>
                    <td>
                      <Deposit contract={contract} walletId={i} />
                    </td>
                    <td>
                      <WalletBalance
                        stakingWalletContract={stakingWalletContract}
                        walletId={i}
                      />
                    </td>
                    <td>
                      <Withdraw contract={contract} walletId={i} />
                    </td>
                    <td>
                      {ethers.utils.formatEther(wallet.stakedAmount) > 0
                        ? 'Yes'
                        : 'No'}
                    </td>
                    <td>
                      <Stake contract={contract} walletId={i} />
                    </td>
                    <td>{ethers.utils.formatEther(wallet.stakedAmount)} ETH</td>
                    <td>
                      <Unstake contract={contract} walletId={i} />
                    </td>
                    <td>
                      <CurrentReward
                        stakingWalletContract={stakingWalletContract}
                        contract={contract}
                        walletId={i}
                      />
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </Table>
        </Row>
      </Container>

      <Container>
        <Row>
          <Button variant='primary' onClick={walletCreate}>
            Create a new Wallet
          </Button>
        </Row>
      </Container>
    </div>
  )
}

export default App
