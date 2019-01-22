pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./IERC721.sol";

//ERC721
contract DogERC721 is IERC721, Ownable {
    
    enum sex {
        Male,
        Female
    }
    
    struct Dog {
        string name;
        uint256 dob;
        string microchip;
        uint256 dam;
        uint256 sire;
        uint256 timestamp;
    }
    
    mapping(address => bool) private _writers;
    mapping(uint256 => address) private _tokenOwner;
    mapping(uint256 => address) private _tokenApprovals

    Dog[] private _pack;

    function totalSupply() public view returns(uint256) {
        return _pack.length;
    }

    function balanceOf(address _owner) external view returns (uint256 _balance) {
        require(owner != address(0), "Invalid address");
        return _ownedTokensCount[owner].current();
    }
    
    function ownerOf(uint256 _tokenId) external view returns (address _owner) {
        return _tokenOwner[_tokenId];
    }
    
    function exists(uint256 _tokenId) external view returns (bool _exists);

    //Could make payable
    function add(string memory name, uint256 dob, uint256 dam, uint256 sire, address owner) public {
        uint id = _pack.length;
        _pack.push(Dog(name, dob, "", dam, sire, now));

        _tokens[id] = owner;
        
        //_mint(_to,id); // Assigns the Token to the Ethereum Address that is specified
    }
    
    // function remove(uint256 index) public {
        
    // }
    
    modifier onlyWriters() {
        require(_writers[msg.sender] = true, "Not authorised");
        _;
    }
}