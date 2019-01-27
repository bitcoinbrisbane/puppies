pragma solidity ^0.5.0;

contract IRepository {
    function add(string calldata name, uint256 dob, string calldata microchip, Sex sex, uint256 dam, uint256 sire, address owner) external;
}