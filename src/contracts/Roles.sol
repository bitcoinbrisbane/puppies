pragma solidity ^0.5.0;

contract Roles {

    mapping(address => bool) private _writers;

    modifier onlyWriters() {
        require(isWriter(msg.sender), "Only the owner can perform this action");
        _;
    }

    function isWriter(address who) public view returns(bool) {
        return _writers[msg.sender];
    }
}