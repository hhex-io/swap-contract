// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";

contract MockNFT is ERC721 {
    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) {}
}
