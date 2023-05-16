// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Swap} from "../../src/Swap.sol";

import {Fixtures_Swap} from "../Fixtures_Swap.sol";

contract Harness_Swap is Swap {
    constructor(uint256 fee_) Swap(fee_) {}

    function exposed_hashSwap(
        Exchange calldata exchange
    ) external pure returns (bytes32) {
        return _hashSwap(exchange);
    }

    function exposed_hashTypedDataV4(
        bytes32 structHash
    ) external view returns (bytes32) {
        return _hashTypedDataV4(structHash);
    }
}

contract SwapTest is Fixtures_Swap {
    Harness_Swap public swap;
    bytes32 public digestExchange;

    function setUp() public {
        swap = new Harness_Swap(FEE);

        _createWallets();
        _createOneNFTWIthOneIdPerWallet();
        _createDefaultEncodedSwap();

        //// grant full allowance to swap contract ////
        vm.prank(ALICE);
        aliceNfts[0].setApprovalForAll(address(swap), true);
        // bob
        vm.prank(BOB);
        bobNfts[0].setApprovalForAll(address(swap), true);

        digestExchange = swap.exposed_hashTypedDataV4(
            swap.exposed_hashSwap(defaultExchange)
        );

        __createSigDefaultExchange();
    }

    /*//////////////////////////////////////////////////////////////
                                 ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_fee_InUSD() public {
        assertEq(swap.feeInUSD(), FEE);
    }

    function test_swap() public {
        assertEq(aliceNfts[0].ownerOf(aliceIds[0]), ALICE);
        assertEq(bobNfts[0].ownerOf(bobIds[0]), BOB);

        vm.prank(BOB);
        swap.swap(defaultExchange, sigAlice, sigBob);

        assertEq(aliceNfts[0].ownerOf(aliceIds[0]), BOB);
        assertEq(bobNfts[0].ownerOf(bobIds[0]), ALICE);
    }

    function __createSigDefaultExchange() private {
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = vm.sign(ALICE_PK, digestExchange);
        sigAlice = bytes.concat(r, s, bytes1(v));

        (v, r, s) = vm.sign(BOB_PK, digestExchange);
        sigBob = bytes.concat(r, s, bytes1(v));
    }
}
