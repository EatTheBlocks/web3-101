import { ethers } from 'ethers'
import { useState } from 'react'
import Button from 'react-bootstrap/Button'
import './App.css'

// const contractAddress = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512'

function App() {
  const [account, setAccount] = useState('')
  const [isActive, setIsActive] = useState(false)
  const [shouldDisable, setShouldDisable] = useState(false) // Should disable connect button while connecting to MetaMask

  // Connect to MetaMask wallet
  const connectToMetamask = async () => {
    console.log('Connecting to MetaMask...')
    setShouldDisable(true)
    try {
      // A Web3Provider wraps a standard Web3 provider, which is
      // what MetaMask injects as window.ethereum into each page
      const provider = new ethers.providers.Web3Provider(window.ethereum)

      // MetaMask requires requesting permission to connect users accounts
      await provider.send('eth_requestAccounts', [])

      // The MetaMask plugin also allows signing transactions to
      // send ether and pay to change state within the blockchain.
      // For this, you need the account signer...
      const signer = provider.getSigner()
      const account = await signer.getAddress()
      setAccount(account)
      setIsActive(true)
      setShouldDisable(false)
    } catch (error) {
      console.log('Error on connecting: ', error)
    }
  }

  // Disconnect from Metamask wallet
  const disconnectFromMetamask = async () => {
    console.log('Disconnecting wallet from App...')
    try {
      setAccount('')
      setIsActive(false)
    } catch (error) {
      console.log('Error on disconnnect: ', error)
    }
  }

  return (
    <div className='App'>
      <header className='App-header'>
        {!isActive ? (
          <>
            <Button
              variant='success'
              onClick={connectToMetamask}
              disabled={shouldDisable}
            >
              <img
                src='images/metamask.svg'
                alt='Metamask'
                width='50'
                height='50'
              />
              Connect to Metamask
            </Button>
          </>
        ) : (
          <>
            <Button variant='danger' onClick={disconnectFromMetamask}>
              <img
                src='images/metamask.svg'
                alt='Metamask'
                width='50'
                height='50'
              />
              Disconnect from Metamask
            </Button>
            <div className='mt-2 mb-2'>Connected Account: {account}</div>
          </>
        )}
      </header>
    </div>
  )
}

export default App
