// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Swap.sol";

/**
* @dev forge script Swap_deploy \
        --rpc-url $BSC_TESTNET --broadcast \
        --verify --etherscan-api-key $BSC_KEY \
        -vvvv --optimize --optimizer-runs 20000 -w
*
* @dev If verification fails:
* forge verify-contract \
    --chain 97 \
    --num-of-optimizations 20000 \
    --compiler-version v0.8.13+commit.abaa5c0e \
    --watch 0xb7DEBdA47C1014763188E69fc823B973eC1749D6 \
    Swap $BSC_KEY
*/
contract Swap_deploy is Script {
    function run() external {
        ///@dev Configure .env file
        string memory SEED = vm.envString("SEED");
        uint256 privateKey = vm.deriveKey(SEED, 0); // address at index 0
        vm.startBroadcast(privateKey);

        Swap token = new Swap(250);

        vm.stopBroadcast();
    }
}
