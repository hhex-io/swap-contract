// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Swap} from "../src/Swap.sol";

/**
 *  @dev we need access to `signEncodedExchangeData`which is why we inherit
 *          from `Swap` instead of `SwapInternal`
 */
contract Mock_SwapInternal is Swap {
    constructor(uint256 fee_) Swap(fee_) {}

    function exposed_isValidSwap(
        bytes memory encodedExchange
    ) public view returns (bool) {
        Exchange memory exchange = abi.decode(encodedExchange, (Exchange));
        Data memory one = abi.decode(exchange.encodedDataPartyOne, (Data));
        Data memory two = abi.decode(exchange.encodedDataPartyTwo, (Data));

        return _isValidSwap(exchange, one, two);
    }
}
