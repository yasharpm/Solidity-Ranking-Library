// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "./FastArray.sol";
import "./RankingRedBlackTree.sol";

library SingleRanking {

	struct Data {
		RankingRedBlackTree.Tree tree;
		mapping(uint => FastArray.Data ) keys;
	}
	
	function add(Data storage _singleRanking, uint _key, uint _value) public {
		_value += 1;
		
		FastArray.Data storage keys = _singleRanking.keys[_value];
		
		if (FastArray.length(keys) == 0) {
			RankingRedBlackTree.insert(_singleRanking.tree, _value);
		}
		else {
			RankingRedBlackTree.addToCount(_singleRanking.tree, _value, 1);
		}
		
		FastArray.insert(_singleRanking.keys[_value], _key);
	}
	
	function remove(Data storage _singleRanking, uint _key, uint _value) public {
		_value += 1;
		
		FastArray.Data storage keys = _singleRanking.keys[_value];
		
		if (FastArray.length(keys) > 0) {
			FastArray.remove(keys, _key);
			
			if (FastArray.length(keys) == 0) {
				RankingRedBlackTree.remove(_singleRanking.tree, _value);
			}
			else {
				RankingRedBlackTree.minusFromCount(_singleRanking.tree, _value, 1);
			}
		}
	}
	
	function get(Data storage _singleRanking, uint _offset, uint _count) public view returns (uint[] memory) {
		require(_offset >= 0, "Offet can not be negative");
		require(_count >= 0 && _count <= 40, "Count must be between 0 and 40");
		
		uint[] memory result = new uint[](_count);
		uint size = 0;
		uint id;
		(id, _offset) = RankingRedBlackTree.lastByOffset(_singleRanking.tree, _offset);
		
		while (id != 0) {
			uint value = RankingRedBlackTree.value(_singleRanking.tree, id);
			FastArray.Data storage keys = _singleRanking.keys[value];

			if (_offset >= FastArray.length(keys)) {
				_offset -= FastArray.length(keys);
			}
			else if (FastArray.length(keys) < _offset + _count) {
				uint index = FastArray.length(keys) - 1;
				
				while (index >= _offset) {
					uint key = FastArray.get(keys, index);
					
					if (key != 0) {
						result[size] = key;
						size += 1;
					}
				
				    if (index == 0) {
				        break;
				    }
				    
					index -= 1;
				}
				
				_count -= FastArray.length(keys) - _offset;
				_offset = 0;
			}
			else {
				uint index = _count - 1;
				
				while (index >= _offset) {
					uint key = FastArray.get(keys, index);
					
					if (key != 0) {
						result[size] = key;
						size += 1;
					}
					
					if (index == 0) {
					    break;
					}
				
					index -= 1;
				}
				result[size] = value;
				break;
			}
			
			id = RankingRedBlackTree.prev(_singleRanking.tree, id);
		}
		
		return result;
	}

}