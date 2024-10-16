// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/UniV3Swap.sol";

contract UniV3SwapTest is Test {
    UniV3Swap public uniV3Swap;
    address SCROLL_SEPOLIA_UNIV3_ROUTER_V2 = 0x17AFD0263D6909Ba1F9a8EAC697f76532365Fb95;
    address WETH_TOKEN = 0x5300000000000000000000000000000000000004;
    address GHO_TOKEN = 0xD9692f1748aFEe00FACE2da35242417dd05a8615;

    address WETH_WHALE = 0x7739E567B9626ca241bdC5528343F92F7e59Af37;
    address GHO_WHALE = 0x5D2D16217C674ECBEDD6cc9C46176363a68196C3;

    function setUp() public {
        uniV3Swap = new UniV3Swap();
    }

    function testBuyGHO() public {
        uint wethBalanceStart = IERC20(WETH_TOKEN).balanceOf(WETH_WHALE);
        uint ghoBalanceStart = IERC20(GHO_TOKEN).balanceOf(WETH_WHALE);
        vm.startPrank(WETH_WHALE);

        uint wEthSent = 0.01 ether;
        IERC20(WETH_TOKEN).approve(address(uniV3Swap), wEthSent);
        uniV3Swap.swap(WETH_TOKEN, GHO_TOKEN, 3000, wEthSent, 1, 0);

        vm.stopPrank();

        uint wethBalanceEnd = IERC20(WETH_TOKEN).balanceOf(WETH_WHALE);
        uint ghoBalanceEnd = IERC20(GHO_TOKEN).balanceOf(WETH_WHALE);
        assertGt(wethBalanceStart, wethBalanceEnd, "wETH balance should decrease.");
        assertLt(ghoBalanceStart, ghoBalanceEnd, "GHO balance should increase.");
    }

    function testBuyWETH() public {
        uint ghoBalanceStart = IERC20(GHO_TOKEN).balanceOf(GHO_WHALE);
        uint wethBalanceStart = IERC20(WETH_TOKEN).balanceOf(GHO_WHALE);
        vm.startPrank(GHO_WHALE);

        uint ghoSent = 10 ether;
        IERC20(GHO_TOKEN).approve(address(uniV3Swap), ghoSent);
        uniV3Swap.swap(GHO_TOKEN, WETH_TOKEN, 3000, ghoSent, 1, 0);

        vm.stopPrank();

        uint ghoBalanceEnd = IERC20(GHO_TOKEN).balanceOf(WETH_WHALE);
        uint wethBalanceEnd = IERC20(WETH_TOKEN).balanceOf(WETH_WHALE);
        assertGt(ghoBalanceStart, ghoBalanceEnd, "GHO balance should decrease.");
        assertLt(wethBalanceStart, wethBalanceEnd, "wETH balance should increase.");
    }
}
