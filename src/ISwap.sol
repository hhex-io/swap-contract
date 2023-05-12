// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";
import {ISwapInternal} from "./ISwapInternal.sol";

interface ISwap {
    /**
     * @dev Both parties sign the same `Exchange` data. With the
     *      signatures we can recover the signers and compare them to
     *      `encodedExchange`.
     * @dev Each parties needs to allow the contract to transfer their
     *      NFTs.
     */
    function swap(
        ISwapInternal.Exchange calldata exchange,
        bytes calldata sigPartyOne,
        bytes calldata sigPartyTwo
    ) external;
}
