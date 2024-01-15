// SPDX-License-Identifier: UNLICENSED
// @author Saswankar Bura Gohain
// @notice This Voting contract allows registered voters to cast votes for candidates.
//         The owner can register voters, voters can cast votes, and the contract tracks votes for each candidate.

pragma solidity 0.8.19;

contract Voting {
    address public owner;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votesReceived;

    event Voted(address indexed voter, bytes32 indexed candidate);

    // Only the owner can call functions with this modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Only registered voters can call functions with this modifier
    modifier onlyVoter() {
        require(voters[msg.sender], "Only registered voters can call this function");
        _;
    }

    // Constructor sets the owner to the deployer of the contract
    constructor() {
        owner = msg.sender;
    }

    /// @notice Allows the owner to register new voters.
    /// @param _voter The address of the voter to be registered.
    function registerVoter(address _voter) external onlyOwner {
        voters[_voter] = true;
    }

    /// @notice Allows registered voters to cast votes for a specific candidate.
    /// @param _candidate The unique identifier of the candidate.
    function vote(bytes32 _candidate) external onlyVoter {
        votesReceived[_candidate]++;
        emit Voted(msg.sender, _candidate);
    }

    /// @notice Retrieves the total number of votes received for a specific candidate.
    /// @param _candidate The unique identifier of the candidate.
    /// @return The total number of votes received for the specified candidate.
    function getVotesForCandidate(bytes32 _candidate) external view returns (uint256) {
        return votesReceived[_candidate];
    }

    /// @notice Determines the winner based on votes.
    /// @return The unique identifier of the winning candidate.
    function getWinner() external view returns (bytes32) {
        bytes32 winner;
        uint256 maxVotes = 0;
        uint256 maxIterations = 100;  // Set a maximum number of iterations
    
        for (bytes32 candidate; maxIterations > 0; candidate = keccak256(abi.encodePacked(candidate))) {
            if (votesReceived[candidate] > maxVotes) {
                maxVotes = votesReceived[candidate];
                winner = candidate;
            }
            maxIterations--;
        }
    
        return winner;
    }

}
