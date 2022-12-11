// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract factory {
    error ZeroAddress();
    error SameToken();
    event pairCreated(
        address indexed tkn1,
        address indexed tkn2,
        address pair,
        uint
    );
    address public feeTo;
    address public feeToSetter;
    address[] pairs;

    mapping(address => mapping(address => address)) getPair;

    constructor(address _feeToSetter) {
        if (_feeToSetter == address(0)) revert ZeroAddress();
        feeToSetter = _feeToSetter;
    }

    //total number of pairs
    function allPairs() external view returns (uint) {
        return pairs.length;
    }

    //creating a new pool
    function createPool(address tokenA, address tokenB) external {
        if (tokenA == address(0) || tokenB == address(0)) revert ZeroAddress();
        if (tokenA == tokenB) revert SameToken();
        //arrange tokenA & B according to which is greater
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        if(getPair[token0][tokenA]!=address(0)) revert PairExists();
        //create the pool pair  
    }
}
