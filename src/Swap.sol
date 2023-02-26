// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {EIP712} from "openzeppelin-contracts/utils/cryptography/EIP712.sol";

import {ISwapInternal} from "./ISwapInternal.sol";
import {ISwap} from "./ISwap.sol";

contract Swap is ISwapInternal, ISwap, EIP712 {
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
}
