// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Message {
    struct MessageData {
        address sender;
        string text;
        uint timestamp;
    }

    mapping(address => uint[]) private messageBlocks;
    mapping(uint => MessageData) private messages;
    address[] private senders;
    uint private messageCounter;

    event NewMessage(address indexed sender, string text, uint timestamp);

    function post(string calldata _message) external {
        require(msg.sender == tx.origin, 'Only works when called directly');

        uint blockNumber = block.number;
        messageBlocks[msg.sender].push(blockNumber);
        messageCounter++;
        uint messageId = messageCounter;

        messages[messageId] = MessageData(msg.sender, _message, block.timestamp);

        if (!isSenderRegistered(msg.sender)) {
            senders.push(msg.sender);
        }

        emit NewMessage(msg.sender, _message, block.timestamp);
    }

    function isSenderRegistered(address sender) private view returns (bool) {
        for (uint i = 0; i < senders.length; i++) {
            if (senders[i] == sender) {
                return true;
            }
        }
        return false;
    }

    function getTotalMessages(address sender) public view returns (uint) {
        return messageBlocks[sender].length;
    }

    function getMessage(uint messageId) public view returns (MessageData memory) {
        return messages[messageId];
    }

    function getAllMessages() public view returns (MessageData[] memory) {
        uint totalMessages = messageCounter;

        MessageData[] memory allMessages = new MessageData[](totalMessages);
        uint index = 0;

        for (uint i = 1; i <= totalMessages; i++) {
            allMessages[index] = getMessage(i);
            index++;
        }

        return allMessages;
    }
}
