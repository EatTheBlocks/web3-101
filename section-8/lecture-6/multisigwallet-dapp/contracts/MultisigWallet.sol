// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

error TxNotExists(uint transactionIndex);
error TxAlreadyApproved(uint transactionIndex);
error TxAlreadySent(uint transactionIndex);

contract MultisigWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event CreateWithdrawTx(
        address indexed owner,
        uint indexed transactionIndex,
        address indexed to,
        uint amount
    );
    event ApproveWithdrawTx(
        address indexed owner,
        uint indexed transactionIndex
    );

    address[] public owners;

    mapping(address => bool) public isOwner;
    uint public quorumRequired;

    struct WithdrawTx {
        address to;
        uint amount;
        uint approvals;
        bool sent;
    }

    mapping(uint => mapping(address => bool)) public isApproved;

    WithdrawTx[] public withdrawTxes;

    constructor(address[] memory _owners, uint _quorumRequired) {
        require(_owners.length > 0, "owners required");
        require(
            _quorumRequired > 0 && _quorumRequired <= _owners.length,
            "invalid number of required quorum"
        );
        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        quorumRequired = _quorumRequired;
    }

    function createWithdrawTx(address _to, uint _amount) public onlyOwner {
        uint transactionIndex = withdrawTxes.length;

        withdrawTxes.push(
            WithdrawTx({to: _to, amount: _amount, approvals: 0, sent: false})
        );
        emit CreateWithdrawTx(msg.sender, transactionIndex, _to, _amount);
    }

    function approveWithdrawTx(uint _transactionIndex)
        public
        onlyOwner
        transactionExists(_transactionIndex)
        transactionNotApproved(_transactionIndex)
        transactionNotSent(_transactionIndex)
    {
        WithdrawTx storage withdrawTx = withdrawTxes[_transactionIndex];
        withdrawTx.approvals += 1;
        isApproved[_transactionIndex][msg.sender] = true;

        if (withdrawTx.approvals >= quorumRequired) {
            withdrawTx.sent = true;
            (bool success, ) = withdrawTx.to.call{value: withdrawTx.amount}("");
            require(success, "transaction failed");
            emit ApproveWithdrawTx(msg.sender, _transactionIndex);
        }
    }

    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function getWithdrawTxCount() public view returns (uint) {
        return withdrawTxes.length;
    }

    function getWithdrawTxes() public view returns (WithdrawTx[] memory) {
        return withdrawTxes;
    }

    function getWithdrawTx(uint _transactionIndex)
        public
        view
        returns (
            address to,
            uint amount,
            uint approvals,
            bool sent
        )
    {
        WithdrawTx storage withdrawTx = withdrawTxes[_transactionIndex];
        return (
            withdrawTx.to,
            withdrawTx.amount,
            withdrawTx.approvals,
            withdrawTx.sent
        );
    }

    function deposit() public payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function balanceOf() public view returns (uint) {
        return address(this).balance;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier transactionExists(uint _transactionIndex) {
        if (_transactionIndex > withdrawTxes.length) {
            revert TxNotExists(_transactionIndex);
        }
        _;
    }

    modifier transactionNotApproved(uint _transactionIndex) {
        if (isApproved[_transactionIndex][msg.sender]) {
            revert TxAlreadyApproved(_transactionIndex);
        }
        _;
    }

    modifier transactionNotSent(uint _transactionIndex) {
        if (withdrawTxes[_transactionIndex].sent) {
            revert TxAlreadySent(_transactionIndex);
        }
        _;
    }
}
