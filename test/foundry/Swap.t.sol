// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Swap} from "../../src/Swap.sol";

contract TokenTest is Test {
    Swap public swap;
    uint256 public constant FEE = 3.4 ether;

    function setUp() public {
        swap = new Swap(FEE);
    }

    /*//////////////////////////////////////////////////////////////
                                 ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_fee_InUSD() public {
        assertEq(swap.feeInUSD(), FEE);
    }
}
