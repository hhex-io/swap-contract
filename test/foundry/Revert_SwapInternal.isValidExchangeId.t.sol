// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {ISwap} from "../../src/ISwap.sol";
import {ISwapInternal} from "../../src/ISwapInternal.sol";

import {Mock_SwapInternal} from "../Mock_SwapInternal.sol";

import {Fixtures_Swap} from "../Fixtures_Swap.sol";

/// @dev Test to verify a swap can be executed
contract Revert_SwapInternalTest_isValidExchangeId is Fixtures_Swap {
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

    function testRevert_isValidExchangeId_When_BothOneTwoWrongExchangeId()
        public
    {
        vm.expectRevert(
            abi.encodeWithSelector(
                ISwapInternal.SwapInternal__InvalidExchangeId.selector,
                "both:one_two"
            )
        );
        swap.exposed_isValidExchangeId(1, 2, 3);
    }

    function testRevert_isValidExchangeId_When_OneWrongExchangeId() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                ISwapInternal.SwapInternal__InvalidExchangeId.selector,
                "one"
            )
        );
        swap.exposed_isValidExchangeId(1, 2, 1);
    }

    function testRevert_isValidExchangeId_When_TwoWrongExchangeId() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                ISwapInternal.SwapInternal__InvalidExchangeId.selector,
                "two"
            )
        );
        swap.exposed_isValidExchangeId(1, 1, 2);
    }
}
