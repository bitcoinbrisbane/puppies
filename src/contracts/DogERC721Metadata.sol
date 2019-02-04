pragma solidity ^0.5.2;

import "./ERC721.sol";
import "./IERC721Metadata.sol";
import "./ERC165.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract DogERC721Metadata is ERC165, ERC721, IERC721Metadata, Ownable {
    using SafeMath for uint256;

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

    Dog[] public pack;
    uint256 public fee;

    string private _name;
    string private _symbol;
    mapping(uint256 => string) private _tokenURIs;

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
    /*
     * 0x5b5e139f ===
     *     bytes4(keccak256('name()')) ^
     *     bytes4(keccak256('symbol()')) ^
     *     bytes4(keccak256('tokenURI(uint256)'))
     */

    //constructor (string memory name, string memory symbol) public {
    constructor () public {
        _name = "BEAGLES"; //name;
        _symbol = "DDA"; //symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    function totalSupply() public view returns(uint256) {
        return pack.length;
    }

    function addPuppy(string calldata dogsName, uint256 dob, string calldata microchip, Sex sex, uint256 dam, uint256 sire, address owner) external payable onlyOwner() {
        require(msg.value >= fee, "Fee too small");
        uint id = pack.length;
        pack.push(Dog(dogsName, dob, microchip, dam, sire, sex, now));

        _tokenOwner[id] = owner;
        _ownedTokensCount[owner] = _ownedTokensCount[owner].add(1);

        emit Transfer(_owner, owner, id);
        emit PuppyAdded(id);
    }

    function getPuppy(uint256 _tokenId) external view returns (string memory, uint256, Sex, uint256, uint256, address) {
        address owner = ownerOf(_tokenId);
        return (pack[_tokenId].name, pack[_tokenId].dob, pack[_tokenId].sex, pack[_tokenId].dam, pack[_tokenId].sire, owner);
    }

    function removePuppy(uint256 _tokenId) external onlyOwner() {
        delete pack[_tokenId];

        emit PuppyRemoved(_tokenId);
    }

    function updateTitle(uint256 _tokenId, string calldata dogsName) external onlyOwner() {
        pack[_tokenId].name = dogsName;
    }

    function setFee(uint256 _fee) public onlyOwner() {
        fee = _fee;
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId), "Token does not exist");
        _tokenURIs[tokenId] = uri;
    }

    event PuppyAdded(uint _tokenId);
    event PuppyRemoved(uint _tokenId);
}
