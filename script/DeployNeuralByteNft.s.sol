// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {NeuralByteNFT} from "../src/NeuralByteNFT.sol";

contract DeployNeuralByteNft is Script {

    string private constant SVG_BASE_URI = "https://firebasestorage.googleapis.com/v0/b/neuralbytenft.appspot.com/o/SvgNFTs";

    string private initSvgUri = string.concat(SVG_BASE_URI, "%2FInitNft.png?alt=media&token=f53afff6-36ad-49d4-8155-c8ef939d53ba");
    string private codemSvgUri = string.concat(SVG_BASE_URI, "%2FCodeMNft.png?alt=media&token=d1c4268c-ce2c-4ad9-b76b-8cf4bbfd8592");
    string private hackrSvgUri = string.concat(SVG_BASE_URI, "%2FHackRNft.png?alt=media&token=a634c7c4-da65-4b95-b1a8-1792293f6d8e");

    function run() external returns (NeuralByteNFT) {
        vm.startBroadcast();
        NeuralByteNFT neuralByteNFT = new NeuralByteNFT(
            initSvgUri,
            codemSvgUri,
            hackrSvgUri
        );
        vm.stopBroadcast();
        return neuralByteNFT;
    }
}