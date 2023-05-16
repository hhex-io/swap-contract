// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapInternal} from "./ISwapInternal.sol";

contract SwapInternal is ISwapInternal {
    bytes32 internal constant _EXCHANGE_TYPEHASH =
        keccak256(
            "Exchange(bytes partyOne,bytes partyTwo,uint256 deadline,uint256 id)"
        );

    function _hashSwap(
        Exchange calldata exchange
    ) internal pure returns (bytes32) {
        return keccak256(abi.encode(_EXCHANGE_TYPEHASH, exchange));
    }
}
