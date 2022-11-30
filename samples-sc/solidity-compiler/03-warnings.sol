
//SPDX-License-Identifier: GPL
pragma solidity ^0.8.13;

contract Warnings {
  uint256 private foo;

  constructor() {}

  function add(uint256 x, uint256 y)
    public pure
    returns (uint256)
  {
    return x + y;
  }

  function update(uint256 x, uint256 y)
    public
  {
    foo = add(x, y);
  }
}
