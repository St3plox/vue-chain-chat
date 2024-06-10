// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Message {
  struct MessageData {
    address sender;
    string text;
  }

  mapping(address => uint[]) private messageBlocks;
  mapping(uint => MessageData) private messages;
  address[] private senders;

  function post(string calldata _message) external {
    require(msg.sender == tx.origin, 'Only works when called directly');

    uint blockNumber = block.number;
    messageBlocks[msg.sender].push(blockNumber);
    uint messageId = messageBlocks[msg.sender].length; // Id of the message within sender's message block

    messages[messageId] = MessageData(msg.sender, _message);

    if (!isSenderRegistered(msg.sender)) {
      senders.push(msg.sender);
    }
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
    uint totalMessages = 0;
    for (uint i = 0; i < senders.length; i++) {
      totalMessages += getTotalMessages(senders[i]);
    }

    MessageData[] memory allMessages = new MessageData[](totalMessages);
    uint index = 0;

    for (uint i = 0; i < senders.length; i++) {
      address sender = senders[i];
      uint senderMessages = getTotalMessages(sender);
      for (uint j = 0; j < senderMessages; j++) {
        uint messageId = messageBlocks[sender][j];
        allMessages[index] = getMessage(messageId);
        index++;
      }
    }

    return allMessages;
  }
}
