// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "./Ranking.sol";

contract RankingTest {
    
    Ranking.Data private ranking;
	
	function test() public returns (uint[] memory) {
		Ranking.add(ranking, 1, 1234, 3);
		Ranking.add(ranking, 1, 7777, 10);
		Ranking.add(ranking, 1, 2222, 10);
		Ranking.add(ranking, 1, 3333, 3);
		Ranking.add(ranking, 1, 4444, 5);
		Ranking.add(ranking, 1, 5555, 100);
		Ranking.remove(ranking, 1, 2222, 10);
		Ranking.add(ranking, 1, 6666, 100);
		Ranking.remove(ranking, 1, 1234, 3);
		
		return Ranking.get(ranking, 1, 0, 10); // Expected: 6666,5555,7777,4444,3333,0,0,0,0,0
	}
	
}