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

        require(
            _isValidExchangeId(exchange.id, one.exchangeId, two.exchangeId)
        );

        return true;
    }

    function _isValidExchangeId(
        uint256 baseExchangeId,
        uint256 oneExchangeId,
        uint256 twoExchangeId
    ) internal view returns (bool) {
        bool areBothInvalid = baseExchangeId != oneExchangeId &&
            baseExchangeId != twoExchangeId;

        if (areBothInvalid) {
            revert SwapInternal__InvalidExchangeId("both:one_two");
        }
        if (baseExchangeId != oneExchangeId) {
            revert SwapInternal__InvalidExchangeId("one");
        }
        if (baseExchangeId != twoExchangeId) {
            revert SwapInternal__InvalidExchangeId("two");
        }

        return true;
    }
}
