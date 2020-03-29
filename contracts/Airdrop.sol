pragma solidity ^0.5.0;
import {ProofMerk} from "./ProofMerk.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
contract MerkleAirDrop {
  IERC20 public token;
  bytes32 public mRoot;
  mapping(address => bool) internal claimed;
  constructor(bytes32 _mRoot, IERC20 _token) public {
    mRoot = _mRoot;
    token = _token;
  }
  function claim(bytes32[] calldata _proof, uint256[] calldata _positions, uint256 _amount) external {
    require(token.balanceOf(address(this)) >= _amount, "insufficient balance");
    require(_proof.length == _positions.length, "incorrect");
    require(!claimed[msg.sender], "already claimed");
    require(ProofMerk.accept(_proof, _positions, mRoot, keccak256(abi.encodePacked(msg.sender, _amount))), "invalid ");
    claimed[msg.sender] = true;
    assert(token.transfer(msg.sender, _amount));
  }
}