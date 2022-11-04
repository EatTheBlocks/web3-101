import React, { useState } from 'react'

import { ethers } from 'ethers'

import Button from 'react-bootstrap/Button'
import Form from 'react-bootstrap/Form'
import Modal from 'react-bootstrap/Modal'

function Deposit(props) {
  const [show, setShow] = useState(false)
  const [ethToUseForDeposit, setEthToUseForDeposit] = useState(0)

  // Deposit ETH to the wallet
  const walletDeposit = async () => {
    if (ethToUseForDeposit > 0) {
      await props.contract.walletDeposit(props.walletId, {
        value: ethers.utils.parseEther(ethToUseForDeposit),
      })
      setEthToUseForDeposit(0)
    }
    setShow(false)
  }
  const handleClose = () => setShow(false)
  const handleShow = () => setShow(true)

  return (
    <>
      <Button variant='success' onClick={handleShow}>
        Deposit some ETH
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Deposit ETH to the wallet</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className='mb-3' controlId='numberInEthDeposit'>
              <Form.Control
                type='text'
                placeholder='Enter the amount in ETH'
                onChange={(e) => setEthToUseForDeposit(e.target.value)}
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant='secondary' onClick={handleClose}>
            Cancel
          </Button>
          <Button variant='primary' onClick={walletDeposit}>
            Deposit
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  )
}

export default Deposit
