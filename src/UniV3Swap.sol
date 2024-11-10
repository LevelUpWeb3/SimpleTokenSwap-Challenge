// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
// Standard ERC20 interface that you can use for internal token transfer
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}
// Uniswap V3 02 router interface with the function that you will need to use for this challenge
interface ISwapRouter02 {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }
    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);
}
contract UniV3Swap {
    // Uniswap Router address deployed at Scroll Sepolia Testnet
    address SCROLL_SEPOLIA_UNIV3_ROUTER_V2 = 0x17AFD0263D6909Ba1F9a8EAC697f76532365Fb95;
    // Trade two tokens in the Uniswap V3 contract deployed at Scroll Sepolia Testnet. You can try it yourself by passing the following params:
    // tokenIn: Contract address of the token you want to sell, for example WETH 0x5300000000000000000000000000000000000004
    // tokenOut: Contract address of the token you want to buy, for example Aave's GHO Stablecoin 0xD9692f1748aFEe00FACE2da35242417dd05a8615
    // fee: Fee that goes to the LP holders, try with 3000 which represents 0.30%
    // amountIn: Amount of tokens you wan't to sell
    // amountOutMinimum: Minimum amount of GHO you want in return
    // sqrtPriceLimitX96: Price limit, used by advanced traders, you can set this to 0 for testing purposes
    function swap(address tokenIn, address tokenOut, uint24 fee, uint256 amountIn, uint256 amountOutMinimum, uint160 sqrtPriceLimitX96)
        external
    {
        // 1. Transfer the tokens the user is Selling, tokenIn
        // 2. Allow or Approve the uniswap router from the tokenIn contract
        // 3. Prepare the ExactInputSingleParams struct bu filling all the parameters
        // 4. Execute the exactInputSingle function
    }
}