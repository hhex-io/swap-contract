// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {IERC721} from "openzeppelin-contracts/token/ERC721/IERC721.sol";

import {Harness_Swap} from "../test/foundry/Swap.t.sol";
import {ISwapInternal} from "../src/ISwapInternal.sol";

/**
* @dev forge script Swap_swap \
        --rpc-url $FTM_RPC --broadcast
*/

contract ERC721Mock is ERC721 {
    constructor() ERC721("NFT", "NFT") {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}

contract Swap_swap is Script {
    bytes32 internal constant _EXCHANGE_TYPEHASH =
        keccak256(
            "ISwapInternal.Exchange(bytes partyOne,bytes partyTwo,uint256 deadline,uint256 id)"
        );

    ISwapInternal.Data public aliceData =
        ISwapInternal.Data(
            IERC721(0xCc72e5AC6E74Ab44BbaAaF1DC9cE62a86f4c8D10),
            0,
            0x772F2B339934da9C4cC939D3b6595DCa104D6c81
        );
    ISwapInternal.Data public bobData =
        ISwapInternal.Data(
            IERC721(0xCc72e5AC6E74Ab44BbaAaF1DC9cE62a86f4c8D10),
            1,
            0xd9A2Fb66B12BCa7Bb99f294E65C97Ae4438bbBDC
        );
    ISwapInternal.Exchange defaultExchange =
        ISwapInternal.Exchange(
            aliceData,
            bobData,
            block.timestamp + 30 days,
            1
        );

    uint8 v;
    bytes32 r;
    bytes32 s;

    bytes public sigAlice;
    bytes public sigBob;

    function run() external {
        ///@dev Configure .env file
        string memory SEED = vm.envString("SEED");
        uint256 alicePK = vm.deriveKey(SEED, 0); // address at index 0
        uint256 bobPK = vm.deriveKey(SEED, 1);

        Harness_Swap swap = Harness_Swap(
            0xebC3D7a5b799380f33BAfe9cB77C65016E5ad5B0
        );
        bytes32 digestExchange = swap.exposed_hashTypedDataV4(
            swap.exposed_hashSwap(defaultExchange)
        );

        // Alice signs
        vm.startBroadcast(alicePK);
        (v, r, s) = vm.sign(alicePK, digestExchange);
        sigAlice = bytes.concat(r, s, bytes1(v));
        vm.stopBroadcast();

        // Bob signs
        vm.startBroadcast(bobPK);
        (v, r, s) = vm.sign(bobPK, digestExchange);
        sigBob = bytes.concat(r, s, bytes1(v));

        // Bob send tx on-chain
        swap.swap(defaultExchange, sigAlice, sigBob);
        vm.stopBroadcast();
    }
}
