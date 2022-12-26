// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721,Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private currentTokenId;
    /// @dev Base token URI used as a prefix by tokenURI().
    string public baseTokenURI;
    uint256 maxNftAmount;
     uint256 public salePrice;
    constructor() ERC721("JobJob", "Jjest") {
      baseTokenURI = "https://gateway.pinata.cloud/ipfs/QmfT4PnipuZ5qxyBEH9ZMhsN8QXxZs6qwUeJhweNYJQTF5/";
       maxNftAmount = 6;
       salePrice = 1000000000000000000;//1 matic
    }
    

     function contractURI() public view returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmdgLXzsDKcXMp6keBPLc338pTbmjfoU86vUkeUT8nn6As/";
    }

    function mintFighter()
        public
        payable
        returns (uint256)
    {
        require(currentTokenId.current() < maxNftAmount);
        require(balanceOf(address(msg.sender)) < 5);
        require(msg.value >= salePrice, 'value sent needs to be atleast sale price');
        currentTokenId.increment();
        uint256 newItemId = currentTokenId.current();
        _safeMint(address(msg.sender), newItemId);
        return newItemId;
    }
  
    /// @dev Returns an URI for a given token ID
  function _baseURI() internal view virtual override returns (string memory) {
    return baseTokenURI;
  }

  /// @dev Sets the base token URI prefix.
  function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
    baseTokenURI = _baseTokenURI;
  }

    function withdraw(address payable owner) public onlyOwner returns(bool) {
        owner.transfer(address(this).balance);
        return true;

    }
    

    function getBalanceContract() public view returns(uint){
        return address(this).balance;
    }
    

  function totalMinted() public view returns (uint) {
        return currentTokenId.current();
    }

}
