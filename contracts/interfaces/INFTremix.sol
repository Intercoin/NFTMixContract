// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

interface INFTremix {
  function ownerOf(address tokenAddress, uint256 tokenId) external view returns(address);
}