// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {NeuralByteNFT} from "../src/NeuralByteNFT.sol";
import {DeployNeuralByteNft} from "../script/DeployNeuralByteNft.s.sol";

contract NeuralByteNftTest is Test {
    NeuralByteNFT neuralByteNft;

    address USER = makeAddr("user");

    function setUp() public {
        DeployNeuralByteNft deployer = new DeployNeuralByteNft();
        neuralByteNft = deployer.run();
    }

    function testViewTokenUri() public {
        vm.prank(USER);
        neuralByteNft.mintNFT();
        console.log(neuralByteNft.tokenURI(0));
        assert(neuralByteNft.getTokenCounter() == 1);
    }
}