// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {EIP712} from "openzeppelin-contracts/utils/cryptography/EIP712.sol";

import {ISwapInternal} from "./ISwapInternal.sol";

contract Swap is ISwapInternal, EIP712 {
    uint256 public feeInUSD;

    constructor(uint256 fee_) EIP712("Hand 2 Hand Exchange", "1") {
        feeInUSD = fee_;
    }
}
