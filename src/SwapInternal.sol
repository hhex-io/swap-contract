// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapInternal} from "./ISwapInternal.sol";

contract SwapInternal is ISwapInternal {
    function _isValidSwap(
        Exchange memory exchange,
        Data memory one,
        Data memory two
    ) internal view returns (bool) {
        require(block.timestamp <= exchange.deadline, "DEADLINE_REACHED");

        return true;
    }
}
