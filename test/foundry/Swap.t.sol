// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../src/Swap.sol";

contract TokenTest is Test {
    Swap public t;

    function setUp() public {
        t = new Swap();
    }

    /*//////////////////////////////////////////////////////////////
                                 BASIC ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_truthy() public {
        assertTrue(true);
    }
}
