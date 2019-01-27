pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./IERC721.sol";

//ERC721
contract DogERC721 is IERC721, Ownable {
    
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
    mapping(uint256 => address) private _tokenOwner;
    mapping(uint256 => address) private _tokenApprovals;

    mapping(address => uint256) private _ownedTokensCount;
    mapping (address => mapping (address => bool)) private operatorApprovals;

    Dog[] public _pack;

    function totalSupply() public view returns(uint256) {
        return _pack.length;
    }

    function balanceOf(address _owner) external view returns (uint256 _balance) {
        require(_owner != address(0), "Invalid address");
        return _ownedTokensCount[_owner];
    }
    
    function ownerOf(uint256 _tokenId) external view returns (address _owner) {
        return _tokenOwner[_tokenId];
    }
    
    function exists(uint256 _tokenId) external view returns (bool _exists) {
        address owner = _tokenOwner[_tokenId];
        return owner != address(0);
    }

    function approve(address _to, uint256 _tokenId) public {
        address owner = _tokenOwner[_tokenId]; //ownerOf(_tokenId);

        require(_to != owner, "Can not be owner");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "Invalid");

        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
        return _tokenApprovals[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return operatorApprovals[_owner][_operator];
    }

    function add(string calldata name, uint256 dob, string calldata microchip, Sex sex, uint256 dam, uint256 sire, address owner) external payable {
        uint id = _pack.length;
        _pack.push(Dog(name, dob, microchip, dam, sire, sex, now));
        _tokenOwner[id] = owner;
    }

    // function add(string memory name, uint256 dob, Sex sex, uint256 dam, uint256 sire, address owner) external payable {
    //     uint id = _pack.length;
    //     _pack.push(Dog(name, dob, "", dam, sire, sex, now));
    //     _tokenOwner[id] = owner;
    // }

    function get(uint256 id) external returns (uint256, string memory, uint256, Sex, uint256, uint256, address) {
        return (_pack[id].id, _pack[id].name, _pack[id].dob, _pack[id].sex, _pack[id].dam, _pack[id].sire, _pack[id].owner);
    }

    modifier onlyWriters() {
        require(_writers[msg.sender] = true, "Not authorised");
        _;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved); 
}