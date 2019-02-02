pragma solidity ^0.5.0;

import "./ERC721.sol";
import "./SafeMath.sol";
import "./IRepository.sol";
import "./Roles.sol";

//ERC721
contract DogERC721 is ERC721, Roles {
    
    using SafeMath for uint;

    enum Sex {
        Male,
        Female
    }
    
    struct Dog {
        string name;
        uint256 dob;
        string microchip;
        uint256 dam;
        uint256 sire;
        Sex sex;
        uint256 timestamp;
    }
    
    mapping(address => bool) private _writers;

    Dog[] public _pack;
    uint256 public fee;

    function totalSupply() public view returns(uint256) {
        return _pack.length;
    }

    function add(string calldata name, uint256 dob, string calldata microchip, Sex sex, uint256 dam, uint256 sire, address owner) external payable onlyOwner() {
        require(msg.value >= fee, "Fee too small");
        uint id = _pack.length;
        _pack.push(Dog(name, dob, microchip, dam, sire, sex, now));
        _tokenOwner[id] = owner;
        _ownedTokensCount[owner] = _ownedTokensCount[owner].add(1);
    }

    function get(uint256 _tokenId) external view returns (string memory, uint256, Sex, uint256, uint256, address) {
        return (_pack[_tokenId].name, _pack[_tokenId].dob, _pack[_tokenId].sex, _pack[_tokenId].dam, _pack[_tokenId].sire, address(0));
    }

    function remove(uint256 _tokenId) external onlyOwner() {
        delete _pack[_tokenId];
    }

    function setFee(uint256 _fee) public onlyOwner() {
        fee = _fee;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved); 
}