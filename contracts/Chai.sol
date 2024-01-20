// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

// @author Saswankar Bura Gohain
// @notice An app to donate ether to me for buying chai

contract Chai{

    struct  Memo{
        string name;
        string message;
        uint timestamp;
        address from;
    }

    Memo[] memos;
    address payable owner; // it will receive all the funds
    constructor(){
        owner = payable(msg.sender);
    }

    function buyChai(string calldata name, string calldata message) external payable {
        require(msg.value > 0, "please pay more than 0 ether");
        owner.transfer(msg.value);
        memos.push(Memo(name, message, block.timestamp, msg.sender));
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
