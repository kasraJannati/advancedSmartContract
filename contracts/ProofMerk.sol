pragma solidity ^0.5.0;

library ProofMerk {
  function accept( bytes32[] memory proof, uint256[] memory positions, bytes32 root,bytes32 leaf) internal pure returns (bool) {
    bytes32 computed = leaf;
    for (uint256 i = 0; i < proof.length; i++) {
      bytes32 proofElement = proof[i];
      if (positions[i] == 1) {
        computed = keccak256(abi.encodePacked(computed, proofElement));
      } else {
        computed = keccak256(abi.encodePacked(proofElement, computed));
      }
    }
    return computed == root;
  }
}