# Solidity Ranking Library

### Description

You have a set of members (identified by a `uint`) which you are assigning scores (`uint`) to which are continuously changing. And you want to query N members with the highest rank in a sorted list. There is also an offset parameter that allows for pagination.

All the operations (insert, remove, query) are performed in O(log n). `n` being the number of unique score values. Note that multiple members can have the same score. Behind the scene a self-balancing red-black tree is used to ensure the order.

### Usage

The library uses an `uint` as category identifier to enable having multiple ranking lists. When you have a new member call `add`. When a member is removed call `remove`. In order to update the score of a member you have to call a `remove` followed by an `add`.

The user of the library is responsible to make sure that `add` is not called consequently for the same member. This check is not done in order to spend is least gas as possible as this library is assumed to be used inside a bigger project that is already validating this.

In order to query the members call `get`. There is a limit on the `count` parameter to avoid running out of gas.

Check `RankingTest.sol` for sample code using the library.

#### Function list

- **add** Inputs are `category`, `key` and `value`. Key is the member's identifier and value is the score assigned to that member. Adds this record to the ranking list belonging to the specified category. Add can not be called multiple times for the same member. You have to remove it first and add it with the new score.
- **remove** Inputs are `category`, `key` and `value`. Removes this record from the category it belongs to. Note that it is expected that you already know the score for the member that is to be removed.
- **get** Inputs are `category`, `offset` and `count`. Returns the top `count` members identifiers for the designated category skipping the first `offset` members. Offset can be any non-negative value. Count should at most be 40. If there are less members than requested, the returned array is padded with zero values. Hence it is strongly recommended to avoid using zero as a member identifier.
- **length** Input is the `category`. Returns the total number of members that exist in this ranking list.



### Disclaimer

This library has the https://unlicense.org/ license. But is using [BokkyPooBahs Red-Black Binary Search Tree Library](https://github.com/bokkypoobah/BokkyPooBahsRedBlackTreeLibrary) which has a MIT license. The license for that file is included within the library file.
