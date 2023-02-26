// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";

interface ISwap {
    function signEncodedExchangeData(
        bytes memory data
    ) external view returns (bytes32 signature);
}
