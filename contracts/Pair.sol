// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Pair {
    error TransferFailed();
    error Locked();
    error NotFactoryAddress();

    uint public constant MIMIMUM_LIQUIDITY = 10 ** 3;
    bytes4 private constant SELECTOR =
        bytes4(keccak256(bytes("transfer(address,uint256)")));

    address public factory;
    address public token0;
    address public token1;

    //reserve  variables are saved on one slot (112+112+32 =256) accessible via getReserves
    uint112 private reserve0;
    uint112 private reserve1;
    uint32 private blockTimestampLast;

    uint public price0CumulativeLast;
    uint public price1CumulativeLast;
    uint public kLast; //K = XY constant product AMM

    uint private unlocked = 1;

    modifier lock() {
        if (unlocked != 1) revert Locked();
        unlocked = 0;
        _;
        unlocked = 1;
    }

    function getReserves()
        external
        view
        returns (
            uint112 _reserve0,
            uint112 _reserve1,
            uint32 _blockTimeStampLast
        )
    {
        _reserve0 = reserve0;
        _reserve1 = reserve1;
        _blockTimeStampLast = blockTimestampLast;
    }

    function _safeTransfer(address token, address to, uint amount) private {
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(SELECTOR, to, amount)
        );
        if (!success && (data.length != 0 || abi.decode(data, (bool))))
            revert TransferFailed();
    }

    constructor() {
        factory = msg.sender;
    }
    function initialize(address _token0, address _token1) external {
        if(msg.sender!= factory) revert NotFactoryAddress();
        token0 = _token0;
        token1 = _token1;
    }

    function update(uint _balance0, uint _balance1, uint112 _reserve0, uint112 _reserve1) private {
        
    }


}
