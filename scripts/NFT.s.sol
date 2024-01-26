// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";

/**
* @dev forge script NFT_deploy \
        --rpc-url $FTM_RPC --broadcast \
        --verify --etherscan-api-key $FTM_KEY \
        -vvvv --optimize --optimizer-runs 20000 -w
*/

contract ERC721Mock is ERC721 {
    constructor() ERC721("NFT", "NFT") {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}

contract NFT_deploy is Script {
    function run() external {
        ///@dev Configure .env file
        string memory SEED = vm.envString("SEED");
        uint256 privateKey = vm.deriveKey(SEED, 0); // address at index 0
        vm.startBroadcast(privateKey);

        ERC721Mock nft = new ERC721Mock();

        vm.stopBroadcast();
    }
}
