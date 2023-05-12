// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";

import {ISwapInternal} from "../../src/ISwapInternal.sol";

import {Swap} from "../../src/Swap.sol";

import {Fixtures_Swap} from "../Fixtures_Swap.sol";

contract SwapTest_fixtures is Fixtures_Swap {
    Swap public swap;

    function setUp() public {
        swap = new Swap(FEE);

        _createWallets();
        _createOneNFTWIthOneIdPerWallet();
        _createDefaultEncodedSwap();
    }

    function testFixtures_createDefaulEncodedData() public {
        // Alice
        assertEq(ERC721(address(aliceNfts[0])).name(), "0_AliceTest");
        assertEq(ERC721(address(aliceNfts[0])).symbol(), "0_A_TST");
        assertEq(ERC721(address(aliceNfts[0])).ownerOf(0), ALICE);
        assertEq(aliceIds[0], 0);
        // Bob
        assertEq(ERC721(address(bobNfts[0])).name(), "0_BobTest");
        assertEq(ERC721(address(bobNfts[0])).symbol(), "0_B_TST");
        assertEq(ERC721(address(bobNfts[0])).ownerOf(0), BOB);
        assertEq(bobIds[0], 0);

        assertEq(defaultExchange.partyOne, aliceEncodedData);
        assertEq(defaultExchange.partyTwo, bobEncodedData);
        assertEq(defaultExchange.deadline, defaultDeadline);
        assertEq(defaultExchange.id, defaultExchangeId);
    }
}
