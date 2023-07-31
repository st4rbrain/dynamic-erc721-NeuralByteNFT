// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { ERC721 } from "@openzeppelin/token/ERC721/ERC721.sol";
import { Base64 } from "@openzeppelin/utils/Base64.sol";
import { Strings } from "@openzeppelin/utils/Strings.sol";


contract NeuralByteNFT is ERC721 {
    error NeuralByteNFT__CantUpgradeIfNotOwner();
    error NeuralByteNFT__MaxLevelReached();

    enum NBLevel {
        INIT,
        CODEM,
        HACKR
    }

    struct NBData {
        NBLevel nbLevel;
        uint256 dateMinted;
    }

    uint256 private s_tokenCounter;
    string private s_initSvgUri;
    string private s_codemSvgUri;
    string private s_hackrSvgUri;

    mapping (uint256 => NBData) private s_tokenIdToNbData;

    constructor(
        string memory initSvgUri, 
        string memory codemSvgUri,
        string memory hackrSvgUri) ERC721 ("Neural Byte", "NEB") {
        s_initSvgUri = initSvgUri;
        s_codemSvgUri = codemSvgUri;
        s_hackrSvgUri = hackrSvgUri;
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToNbData[s_tokenCounter] = NBData(NBLevel.INIT, block.timestamp);
        s_tokenCounter += 1;
    }

    function upgradeNFT(uint256 tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert NeuralByteNFT__CantUpgradeIfNotOwner();
        }

        uint256 currentLevel = uint256(s_tokenIdToNbData[tokenId].nbLevel);
        if (currentLevel == 2) {
            revert NeuralByteNFT__MaxLevelReached();
        }
        s_tokenIdToNbData[tokenId].nbLevel = NBLevel(currentLevel+1);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory svgUri;
        if (s_tokenIdToNbData[tokenId].nbLevel == NBLevel.INIT) {
            svgUri = s_initSvgUri;
        } else if (s_tokenIdToNbData[tokenId].nbLevel == NBLevel.CODEM) {
            svgUri = s_codemSvgUri;
        } else {
            svgUri = s_hackrSvgUri;
        }

        return string(abi.encodePacked(
            _baseURI(),
            Base64.encode(bytes(abi.encodePacked(
            '{ "name": "', name(), '", "description": "Embark on a coding odyssey, a dynamic journey from Init to CodeM to HackR, showcasing your competitive programming prowess.", "image": "', svgUri, '", "attributes": [{ "trait_type": "Mint Timestamp", "value": "', 
            Strings.toString(s_tokenIdToNbData[tokenId].dateMinted), '" }]}'
        )))));

    }

    function getTokenIdToNbData(uint256 tokenId) external view returns (NBData memory) {
        return s_tokenIdToNbData[tokenId];
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}