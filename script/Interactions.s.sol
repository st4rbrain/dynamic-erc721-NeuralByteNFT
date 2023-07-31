// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {NeuralByteNFT} from "../src/NeuralByteNFT.sol";
import {DevOpsTools} from "foundry-devops/DevOpsTools.sol";

contract MintNeuralByteNft is Script {
    function mintNFTOnContract(address neuralByteNft) public {
        vm.startBroadcast();
        NeuralByteNFT(neuralByteNft).mintNFT();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("NeuralByteNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }
}