// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {EIP712} from "openzeppelin-contracts/utils/cryptography/EIP712.sol";

import {ECDSA} from "openzeppelin-contracts/utils/cryptography/ECDSA.sol";

import {ISwap} from "./ISwap.sol";

import {SwapInternal} from "./SwapInternal.sol";

contract Swap is ISwap, SwapInternal, EIP712 {
    uint256 public feeInUSD;

    constructor(uint256 fee_) EIP712("Hand 2 Hand Exchange", "1") {
        feeInUSD = fee_;
    }

    /**
     * @inheritdoc ISwap
     */
    function swap(
        Exchange calldata exchange,
        bytes calldata sigPartyOne,
        bytes calldata sigPartyTwo
    ) external {
        Data memory one = abi.decode(exchange.partyOne, (Data));
        Data memory two = abi.decode(exchange.partyTwo, (Data));

        bytes32 digest = _hashTypedDataV4(_hashSwap(exchange));
        require(
            ECDSA.recover(digest, sigPartyOne) == two.to,
            "Tx Initiator Recovery Failed"
        );
        require(
            ECDSA.recover(digest, sigPartyTwo) == one.to,
            "TX Validator Recovery Failed"
        );
        require(block.timestamp <= exchange.deadline, "DEADLINE_REACHED");
        require(msg.sender == one.to, "NOT_TX_VALIDATOR");

        one.nft.safeTransferFrom(two.to, one.to, one.nftId);
        two.nft.safeTransferFrom(one.to, two.to, two.nftId);
    }
}
