import React, { useState } from 'react'

import { ethers } from 'ethers'

import Button from 'react-bootstrap/Button'
import Form from 'react-bootstrap/Form'
import Modal from 'react-bootstrap/Modal'

function Withdraw(props) {
  const [show, setShow] = useState(false)
  const [ethToUseForWithdrawal, setEthToUseForWithdrawal] = useState(0)
  const [ethAddrToUseForWithdrawal, setEthAddrToUseForWithdrawal] = useState(
    ethers.constants.AddressZero
  )

  // Withdraw ETH from the wallet
  const walletWithdraw = async () => {
    if (
      ethToUseForWithdrawal > 0 &&
      ethAddrToUseForWithdrawal !== ethers.constants.AddressZero
    ) {
      await props.contract.walletWithdraw(
        props.walletId,
        ethAddrToUseForWithdrawal,
        ethers.utils.parseEther(ethToUseForWithdrawal)
      )
      setEthToUseForWithdrawal(0)
      setEthAddrToUseForWithdrawal(ethers.constants.AddressZero)
    }
    setShow(false)
  }

  const handleClose = () => setShow(false)
  const handleShow = () => setShow(true)

  return (
    <>
      <Button variant='danger' onClick={handleShow}>
        Withdraw ETH
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Withdraw ETH from the wallet</Modal.Title>
        </Modal.Header>
        <Modal.Body>
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
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant='secondary' onClick={handleClose}>
            Cancel
          </Button>
          <Button variant='primary' onClick={walletWithdraw}>
            Withdraw
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  )
}

export default Withdraw
