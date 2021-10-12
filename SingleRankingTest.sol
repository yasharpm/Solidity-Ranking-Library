// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "./SingleRanking.sol";

contract SingleRankingTest {
    
    SingleRanking.Data private singleRanking;
	
	function test() public returns (uint[] memory) {
		SingleRanking.add(singleRanking, 1234, 3);
		SingleRanking.add(singleRanking, 7777, 10);
		SingleRanking.add(singleRanking, 2222, 10);
		SingleRanking.add(singleRanking, 3333, 3);
		SingleRanking.add(singleRanking, 4444, 5);
		SingleRanking.add(singleRanking, 5555, 100);
		SingleRanking.remove(singleRanking, 2222, 10);
		SingleRanking.add(singleRanking, 6666, 100);
		SingleRanking.remove(singleRanking, 1234, 3);
		
		return SingleRanking.get(singleRanking, 0, 10); // Expected: 6666,5555,7777,4444,3333,0,0,0,0,0
	}

}