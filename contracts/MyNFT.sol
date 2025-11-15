// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; // match OpenZeppelin ^0.8.20

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title MyNFT - simple ERC721 with owner-only mint and base URI
contract MyNFT is ERC721, Ownable {
    uint256 private _nextTokenId;
    string private _baseTokenURI;

    // Manual storage for token URIs (since ERC721URIStorage was removed in OZ 5.x)
    mapping(uint256 => string) private _tokenURIs;

    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseURI_
    ) 
        ERC721("MyNFT", "MNFT") 
        Ownable(msg.sender)
    {
        _baseTokenURI = "http://localhost:3000/metadata/";
        _nextTokenId = 1;
    }

    /// @notice Owner-only mint
    function mint(address to, string memory tokenURI_) 
        external 
        onlyOwner 
        returns (uint256) 
    {
        uint256 tokenId = _nextTokenId;
        _safeMint(to, tokenId);

        if (bytes(tokenURI_).length > 0) {
            _tokenURIs[tokenId] = tokenURI_;
        }

        _nextTokenId++;
        return tokenId;
    }

    /// @notice Return tokenURI: stored or fallback to baseURI + id
    function tokenURI(uint256 tokenId) 
        public 
        view 
        override 
        returns (string memory) 
    {
        string memory stored = _tokenURIs[tokenId];
        if (bytes(stored).length > 0) {
            return stored;
        }

        return string(abi.encodePacked(_baseTokenURI, _uint2str(tokenId)));
    }

    /// @notice Update base URI
    function setBaseURI(string calldata baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
    }

    /// @dev helper: convert uint to string
    function _uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) return "0";

        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }

        bytes memory bstr = new bytes(len);
        uint k = len;
        j = _i;

        while (j != 0) {
            k -= 1;
            bstr[k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }

        return string(bstr);
    }
}
