// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Constructor1 {
	string public text;

	constructor(string _t) {
        text = _t;
  }
}

contract Constructor2 {
  constructor() {
  }
}

