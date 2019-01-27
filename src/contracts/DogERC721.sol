pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./IERC721.sol";
import "./SafeMath.sol";

//ERC721
contract DogERC721 is IERC721 {
    
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
    
    function exists(uint256 _tokenId) external view returns (bool _exists) {
        //address owner = _tokenOwner[_tokenId];
        return ownerOf(_tokenId) != address(0);
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return _tokenOwner[_tokenId];
    }

    function approve(address _to, uint256 _tokenId) external {
        address owner = ownerOf(_tokenId);

        require(_to != owner, "Can not be owner");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "Invalid");

        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function getApproved(uint256 _tokenId) public view returns (address) {
        return _tokenApprovals[_tokenId];
    }

    function setApprovalForAll(address _to, bool _approved) public {
        require(_to != msg.sender);
        operatorApprovals[msg.sender][_to] = _approved;
        emit ApprovalForAll(msg.sender, _to, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return operatorApprovals[_owner][_operator];
    }
    
    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        require(_from != address(0));
        require(_to != address(0));

        clearApproval(_from, _tokenId);
        removeTokenFrom(_from, _tokenId);
        addTokenTo(_to, _tokenId);

        emit Transfer(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external {
        //safeTransferFrom(_from, _to, _tokenId, "");
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata _data) external {
        transferFrom(_from, _to, _tokenId);
    }

    function add(string calldata name, uint256 dob, string calldata microchip, Sex sex, uint256 dam, uint256 sire, address owner) external payable {
        uint id = _pack.length;
        _pack.push(Dog(name, dob, microchip, dam, sire, sex, now));
        _tokenOwner[id] = owner;
    }

    // function add(string calldata name, uint256 dob, Sex sex, uint256 dam, uint256 sire, address owner) external payable {
    //     uint id = _pack.length;
    //     _pack.push(Dog(name, dob, "", dam, sire, sex, now));
    //     _tokenOwner[id] = owner;
    // }

    function get(uint256 _tokenId) external view returns (string memory, uint256, Sex, uint256, uint256, address) {
        return (_pack[_tokenId].name, _pack[_tokenId].dob, _pack[_tokenId].sex, _pack[_tokenId].dam, _pack[_tokenId].sire, address(0));
    }

    function isApprovedOrOwner(address _spender, uint256 _tokenId) internal view returns (bool) {
        address owner = _tokenOwner[_tokenId];
        return (_spender == owner || getApproved(_tokenId) == _spender || isApprovedForAll(owner, _spender));
    }

    function addTokenTo(address _to, uint256 _tokenId) internal {
        require(_tokenOwner[_tokenId] == address(0));
        _tokenOwner[_tokenId] = _to;
        _ownedTokensCount[_to] = _ownedTokensCount[_to] + 1;
    }

    function removeTokenFrom(address _from, uint256 _tokenId) internal {
        require(ownerOf(_tokenId) == _from);
        _ownedTokensCount[_from] = _ownedTokensCount[_from] - 1;
        _tokenOwner[_tokenId] = address(0);
    }

    function clearApproval(address _owner, uint256 _tokenId) internal {
        require(ownerOf(_tokenId) == _owner);

        if (_tokenApprovals[_tokenId] != address(0)) {
            _tokenApprovals[_tokenId] = address(0);
        }
    }

    modifier onlyDogOwner(uint256 _tokenId) {
        require(_writers[msg.sender] = true, "Not authorised");
        _;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved); 
}