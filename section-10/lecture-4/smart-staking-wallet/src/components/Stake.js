import React, { useState } from 'react'

import Button from 'react-bootstrap/Button'
import Modal from 'react-bootstrap/Modal'

function Stake(props) {
  const [show, setShow] = useState(false)
  // Stake ETH to the staking pool
  const stakeEth = async () => {
    await props.contract.stakeEth(props.walletId)
    setShow(false)
  }

  const handleClose = () => setShow(false)
  const handleShow = () => setShow(true)

  return (
    <>
      <Button variant='primary' onClick={handleShow}>
        Stake everything
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Stake ETH to the staking pool</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          This will stake all the ETH from your wallet to the staking pool and
          you will start to earn rewards in the form of WEB3 ERC20 tokens
        </Modal.Body>
        <Modal.Footer>
          <Button variant='secondary' onClick={handleClose}>
            Cancel
          </Button>
          <Button variant='primary' onClick={stakeEth}>
            Confirm
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  )
}

export default Stake
