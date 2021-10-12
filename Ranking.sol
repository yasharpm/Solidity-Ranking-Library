// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "./SingleRanking.sol";

library Ranking {

	struct Data {
		mapping(uint => SingleRanking.Data) rankings;
	}
	
	function add(Data storage _rankings, uint _category, uint _key, uint _value) internal {
		SingleRanking.add(_rankings.rankings[_category], _key, _value);
	}
	
	function remove(Data storage _rankings, uint _category, uint _key, uint _value) internal {
		SingleRanking.remove(_rankings.rankings[_category], _key, _value);
	}
	
	function length(Data storage _rankings, uint _category) public view returns (uint) {
		return SingleRanking.length(_rankings.rankings[_category]);
	}
	
	function get(Data storage _rankings, uint _category, uint _offset, uint _count) public view returns (uint[] memory) {
		return SingleRanking.get(_rankings.rankings[_category], _offset, _count);
	}

}