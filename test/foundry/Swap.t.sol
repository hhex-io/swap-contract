// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Swap} from "../../src/Swap.sol";

import {Fixtures_Swap} from "../Fixtures_Swap.sol";

contract TokenTest is Fixtures_Swap {
    Swap public swap;

    function setUp() public {
        swap = new Swap(FEE);

        _createWallets();
    }

    /*//////////////////////////////////////////////////////////////
                                 ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_fee_InUSD() public {
        assertEq(swap.feeInUSD(), FEE);
    }
}
