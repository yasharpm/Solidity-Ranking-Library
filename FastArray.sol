// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

// An array that is supposed to hold unique values. The purpose is optimization on gas use.
// The length is always incremental. 
library FastArray {

	struct Data {
		mapping(uint => uint) array;
		mapping(uint => uint) indexMap;
		uint length;
	}

	function insert(Data storage _fastArray, uint _value) public {
	    _fastArray.array[_fastArray.length] = _value;
		_fastArray.indexMap[_value] = _fastArray.length;
		_fastArray.length += 1;
	}
	
	function remove(Data storage _fastArray, uint _value) public {
		uint index = _fastArray.indexMap[_value];
		_fastArray.array[index] = _fastArray.array[_fastArray.length - 1];
		delete _fastArray.indexMap[_value];
		_fastArray.length -= 1;
	}
	
	function get(Data storage _fastArray, uint _index) public view returns (uint) {
		return _fastArray.array[_index];
	}
	
	function length(Data storage _fastArray) public view returns (uint) {
		return _fastArray.length;
	}
	
	function contains(Data storage _fastArray, uint _value) public view returns (bool) {
		return _fastArray.indexMap[_value] != 0;
	}

}