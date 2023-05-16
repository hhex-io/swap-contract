// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";

import {ISwapInternal} from "../src/ISwapInternal.sol";
import {ISwap} from "../src/ISwap.sol";

import {MockNFT} from "./MockNFT.sol";

contract Fixtures_Swap is Test, ISwapInternal {
    /*//////////////////////////////////////////////////////////////
                            SWAP ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    uint256 public constant FEE = 3.4 ether;

    /*//////////////////////////////////////////////////////////////
                            WALLETS
    //////////////////////////////////////////////////////////////*/
    uint256 public ALICE_PK;
    uint256 public BOB_PK;
    address public ALICE;
    address public BOB;

    /*//////////////////////////////////////////////////////////////
                            EXCHANGE DATA
    //////////////////////////////////////////////////////////////*/
    IERC721[] public aliceNfts;
    uint256[] public aliceIds;
    IERC721[] public bobNfts;
    uint256[] public bobIds;
    // default encoded `Data`
    Data public aliceData;
    Data public bobData;
    // default signatures
    bytes public sigAlice;
    bytes public sigBob;
    // default `Exchange` data
    SwapType public defaultSwapType = SwapType.ONE_TO_ONE;
    uint256 public defaultDeadline = block.timestamp + 1 days;
    uint256 public defaultExchangeId = 1;
    bytes public defaultEncodedExchange;
    Exchange public defaultExchange;

    function _createWallets() internal {
        (ALICE, ALICE_PK) = makeAddrAndKey("Alice_PK");
        (BOB, BOB_PK) = makeAddrAndKey("Bob_PK");
    }

    function _createOneNFTWIthOneIdPerWallet() internal {
        MockNFT nft;
        for (uint256 i; i < 1; ++i) {
            // Alice
            nft = new MockNFT(
                string.concat(Strings.toString(i), "_AliceTest"),
                string.concat(Strings.toString(i), "_A_TST")
            );
            nft.mint(ALICE, i);
            aliceNfts.push(IERC721(nft));
            aliceIds.push(i);
            // Bob
            nft = new MockNFT(
                string.concat(Strings.toString(i), "_BobTest"),
                string.concat(Strings.toString(i), "_B_TST")
            );
            nft.mint(BOB, i);
            bobNfts.push(IERC721(nft));
            bobIds.push(i);
        }
    }

    /// @dev Creates default encoded `Ecxhange` fro; `Data` with default nfts and ids
    function _createDefaultEncodedSwap() internal {
        aliceData = Data(aliceNfts[0], aliceIds[0], BOB);
        bobData = Data(bobNfts[0], bobIds[0], ALICE);
        defaultExchange = Exchange(
            aliceData,
            bobData,
            defaultDeadline,
            defaultExchangeId
        );
        defaultEncodedExchange = abi.encode(defaultExchange);
    }
}
