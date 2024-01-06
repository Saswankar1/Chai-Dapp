// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Voting {
    address public owner;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votesReceived;

    event Voted(address indexed voter, bytes32 indexed candidate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyVoter() {
        require(voters[msg.sender], "Only registered voters can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerVoter(address _voter) external onlyOwner {
        voters[_voter] = true;
    }

    function vote(bytes32 _candidate) external onlyVoter {
        votesReceived[_candidate]++;
        emit Voted(msg.sender, _candidate);
    }

    function getVotesForCandidate(bytes32 _candidate) external view returns (uint256) {
        return votesReceived[_candidate];
    }

    function getWinner() external view returns (bytes32) {
        bytes32 winner;
        uint256 maxVotes = 0;

        // Loop through all candidates to find the one with the most votes
        // Note: This is a simple example; in a real-world scenario, you might want to handle ties differently.
        for (bytes32 candidate; true; candidate = keccak256(abi.encodePacked(candidate))) {
            if (votesReceived[candidate] > maxVotes) {
                maxVotes = votesReceived[candidate];
                winner = candidate;
            }
        }

        return winner;
    }
}
