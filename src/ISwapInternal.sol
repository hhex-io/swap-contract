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
        IERC721 nft;
        uint256 nftId;
        address to;
    }

    struct Exchange {
        // encoded Data for party one - tx initiator
        bytes partyOne;
        // encoded Data for party two - tx validator
        bytes partyTwo;
        uint256 deadline;
        uint256 id;
    }
}
