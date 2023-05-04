// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Ownable {
    address private _owner;

    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner {
        require(msg.sender == _owner, "Sender's address does not match the contract owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnerChanged(_owner, newOwner);
        _owner = newOwner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function getOwner() public  view returns (address) {
        return _owner;
    }
}