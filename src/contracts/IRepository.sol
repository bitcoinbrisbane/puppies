pragma solidity ^0.5.0;

contract IRepository {
    function add(string calldata name, uint256 dob, uint8 sex, string calldata microchip, uint256 dam, uint256 sire, address owner) external;
    function get(uint256 _tokenId) external returns (string memory, uint256, uint8, uint256, uint256, address);
    function remove(uint256 _tokenId) external;
}