// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {EIP712} from "openzeppelin-contracts/utils/cryptography/EIP712.sol";

import {ISwap} from "./ISwap.sol";

import {SwapInternal} from "./SwapInternal.sol";

contract Swap is ISwap, SwapInternal, EIP712 {
    uint256 public feeInUSD;

    constructor(uint256 fee_) EIP712("Hand 2 Hand Exchange", "1") {
        feeInUSD = fee_;
    }

    /**
     * @dev One party sign their encoded exchange `Data` to start an exchange
     *      within this contract and on this chain.
     */
    function signEncodedExchangeData(
        bytes memory data
    ) external view override returns (bytes32 signature) {
        signature = _hashTypedDataV4(keccak256(data));
    }

    function swap(bytes memory encodedExchange) external {
        Exchange memory exchange = abi.decode(encodedExchange, (Exchange));
        Data memory one = abi.decode(exchange.encodedDataPartyOne, (Data));
        Data memory two = abi.decode(exchange.encodedDataPartyTwo, (Data));

        require(_isValidSwap(exchange, one, two));
    }
}
