// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "./FastArray.sol";

contract TestContract {
    
    FastArray.Data private fastArray;
 
	
	function test() public returns (uint) {
		FastArray.insert(fastArray, 1);
		FastArray.insert(fastArray, 2);
		FastArray.insert(fastArray, 3);
		
		FastArray.remove(fastArray, 2);
		
		require(!FastArray.contains(fastArray, 2), "2 should be removed but is not!");
		require(FastArray.length(fastArray) == 2, "Array length is not 2.");
		require(FastArray.get(fastArray, 0) == 1, "First index should be 1");
		require(FastArray.get(fastArray, 1) == 3, "Second index should be 3");
		
		return 0;
	}

}