pragma solidity ^0.5.0;

import "./Ownable.sol";

contract Roles is Ownable {

    mapping(address => bool) private _writers;

    function addWriter(address who) public onlyOwner() {
        require(who != address(0), "Invalid address");
        _writers[who] = true;
    }

    function removeWriter(address who) public onlyOwner() {
        require(who != address(0), "Invalid address");
        delete _writers[who];
    }

    function isWriter(address who) public view returns(bool) {
        require(who != address(0), "Invalid address");
        return _writers[msg.sender];
    }

    modifier onlyWriters() {
        require(isWriter(msg.sender) || isOwner(), "Only the owner can perform this action");
        _;
    }
}