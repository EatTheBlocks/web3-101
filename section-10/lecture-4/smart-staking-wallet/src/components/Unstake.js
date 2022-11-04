import React, { useState } from 'react'

import Button from 'react-bootstrap/Button'
import Modal from 'react-bootstrap/Modal'

import StakedBalance from './StakedBalance'

function Unstake(props) {
  const [show, setShow] = useState(false)
  // Unstake ETH from the staking pool
  const unstakeEth = async () => {
    await props.contract.unstakeEth(props.walletId)
    setShow(false)
  }

  const handleClose = () => setShow(false)
  const handleShow = () => setShow(true)

  return (
    <>
      <Button variant='primary' onClick={handleShow}>
        Unstake everything
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Unstake ETH from the staking pool</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          This will unstake all the ETH from your staking pool and the ETH will
          be deposited to your wallet. You will get rewarded with the
          appropriate amount of WEB3 ERC20 tokens
          <br />
          <br />
          You're about to unstake{' '}
          <span style={{ fontWeight: 'bold' }}>
            {' '}
            <StakedBalance
              stakingWalletContract={props.stakingWalletContract}
              walletId={props.walletId}
            />
          </span>
        </Modal.Body>
        <Modal.Footer>
          <Button variant='secondary' onClick={handleClose}>
            Cancel
          </Button>
          <Button variant='primary' onClick={unstakeEth}>
            Confirm
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  )
}

export default Unstake
