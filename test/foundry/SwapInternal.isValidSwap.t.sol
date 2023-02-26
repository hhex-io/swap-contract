// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {ISwap} from "../../src/ISwap.sol";

import {Mock_SwapInternal} from "../Mock_SwapInternal.sol";

import {Fixtures_Swap} from "../Fixtures_Swap.sol";

/// @dev Test to verify a swap can be executed
contract SwapInternalTest_isValidSwap is Fixtures_Swap {
    Mock_SwapInternal public swap;

    function setUp() public {
        swap = new Mock_SwapInternal(FEE);

        _createWallets();
        // create default exchange data
        _createOneNFTWIthOneIdPerWallet();
        _createDefaulEncodedData();
        _createDefaultSigFromData(ISwap(swap));
        _createDefaultExchange();
    }

    function test_isValidSwap_VerifyWholeEncodedExchangeData() public {
        assertTrue(swap.exposed_isValidSwap(defaultEncodedExchange));
    }
}
