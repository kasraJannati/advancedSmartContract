pragma solidity >=0.4.22 <0.7.0;
contract Migrations {
  address public owner;
  uint256 public lastMigration;
  modifier restricted() {
    if (msg.sender == owner) _;
  }
  constructor() public {
    owner = msg.sender;
  }
  function setCompleted(uint completed) public restricted {
    lastMigration = completed;
  }
}
