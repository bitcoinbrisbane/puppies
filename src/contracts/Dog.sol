pragma solidity ^0.5.0;

import "./Ownable.sol";

//ERC721
contract DogERC721 is Ownable {
    //function balanceOf(address _owner) public view returns (uint256 _balance);
    //function ownerOf(uint256 _tokenId) public view returns (address _owner);
    //function exists(uint256 _tokenId) public view returns (bool _exists);
    
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
    mapping(address => uint256) private _tokens;

    Dog[] private _pack;

    //Could make payable
    function add(string memory name, uint256 dob, uint256 dam, uint256 sire, address owner) public {
        uint id = _pack.length;
        _pack.push(Dog(name, dob, "", dam, sire, now));

        _tokens[owner] = id;
        
        //_mint(_to,id); // Assigns the Token to the Ethereum Address that is specified
    }
    
    // function remove(uint256 index) public {
        
    // }
    
    modifier onlyWriters() {
        require(_writers[msg.sender] = true, "Not authorised");
        _;
    }
}