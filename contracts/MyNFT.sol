// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title MyNFT - simple ERC721 with owner-only mint and base URI
contract MyNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    string private _baseTokenURI;

    constructor(string memory name_, string memory symbol_, string memory baseURI_) ERC721(name_, symbol_) {
        _baseTokenURI = baseURI_;
        _nextTokenId = 1;
    }

    /// @notice Owner-only mint to `to`, with optional tokenURI (full URI or blank to use base+id)
    function mint(address to, string memory tokenURI_) external onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId;
        _safeMint(to, tokenId);
        if (bytes(tokenURI_).length > 0) {
            _setTokenURI(tokenId, tokenURI_);
        }
        _nextTokenId++;
        return tokenId;
    }

    /// @notice Optional: override tokenURI to return base + tokenId if no per-token URI set
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory _tokenURI = super.tokenURI(tokenId); // from ERC721URIStorage
        if (bytes(_tokenURI).length > 0) {
            return _tokenURI;
        }

        // default to base + tokenId
        return string(abi.encodePacked(_baseTokenURI, _uint2str(tokenId)));
    }

    /// @notice Allow owner to update base URI
    function setBaseURI(string calldata baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
    }

    /// @dev helper: convert uint to string (simple)
    function _uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
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
            k = k - 1;
            uint8 temp = uint8(48 + (j % 10));
            bstr[k] = bytes1(temp);
            j /= 10;
        }
        return string(bstr);
    }
}
