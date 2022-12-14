// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract StructContract {
    struct Book {
        string title;
        bool isFiction;
    }

    // An array of book structs
    Book[] public books;

    function create(string calldata _title, bool _isFiction) public {
        // 3 ways to initialize a struct
        // calling it like a function
        books.push(Book(_title, _isFiction));

        // key value mapping
        books.push(Book({title: _title, isFiction: _isFiction}));

        // initialize an empty struc and then update it later
        Book memory book;
        book.title = _title;
        // book.isFiction = _isFiction;
    }

    // Solidity automatically creates a getter for "books"
    // so you don't actually need this function
    function get(uint _index)
        public
        view
        returns (string memory title, bool isFiction)
    {
        Book storage book = books[_index];
        return (book.title, book.isFiction);
    }

    // update the title
    function updateTitle(uint _index, string calldata _title) public {
        Book storage book = books[_index];
        book.title = _title;
    }

    // update isFiction
    function toggleIsFiction(uint _index) public {
        Book storage book = books[_index];
        book.isFiction = !book.isFiction;
    }
}
