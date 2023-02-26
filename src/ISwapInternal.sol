// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";

interface ISwapInternal {
    enum SwapType {
        ONE_TO_ONE,
        ONE_TO_MANY,
        MANY_TO_ONE,
        MANY_TO_MANY
    }

    struct Data {
        IERC721[] nfts;
        uint256[] ids;
        address to;
        uint256 exchangeId;
    }

    struct Exchange {
        bytes encodedDataPartyOne;
        bytes encodedDataPartyTwo;
        bytes32 sigPartyOne;
        bytes32 sigPartyTwo;
        SwapType swapType;
        uint256 deadline;
        uint256 id;
    }
}
