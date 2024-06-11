<template>
  <div id="app" class="centered">
    <div class="chat-box">
      <div class="messages">
        <div v-for="message in messages" :key="message.timestamp" class="message">
          <strong>{{ message.sender }}:</strong> {{ message.text }} <span class="timestamp">{{ formatTimestamp(message.timestamp) }}</span>
        </div>
      </div>
      <div class="input-box">
        <input type="text" v-model="newMessage" @keyup.enter="sendMessage" placeholder="Type a message..." />
        <button @click="sendMessage">Send</button>
      </div>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';
import messageContractConfig from './contracts/cfg/message_contract.json';

export default {
  data() {
    return {
      web3: null,
      contract: null,
      messages: [],
      newMessage: ''
    };
  },
  methods: {
    async loadMessages() {
      const messages = await this.contract.methods.getAllMessages().call();
      this.messages = messages.map(message => ({
        sender: message.sender,
        text: message.text,
        timestamp: Number(message.timestamp)
      }));
    },
    async sendMessage() {
      if (this.newMessage.trim() === '') return;

      try {
        // Request authentication from MetaMask
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const sender = accounts[0]; // Use the first account
        await this.contract.methods.post(this.newMessage).send({ from: sender });

        this.newMessage = '';
        this.loadMessages();
      } catch (error) {
        console.error('Error sending message:', error);
      }
    },
    formatTimestamp(timestamp) {
      return new Date(timestamp * 1000).toLocaleString();
    }
  },
  async mounted() {
    if (typeof window.ethereum !== 'undefined') {
      this.web3 = new Web3(window.ethereum);
      try {
        // Request account access if needed
        await window.ethereum.enable();
        this.contract = new this.web3.eth.Contract(messageContractConfig.abi, messageContractConfig.address);
        this.loadMessages();

        // Listen for new messages
        this.contract.events.NewMessage()
          .on('data', (event) => {
            this.loadMessages();
          });
      } catch (error) {
        console.error('Error accessing MetaMask accounts:', error);
      }
    } else {
      console.error('MetaMask not detected');
    }
  }
};
</script>

<style>
#app {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh; /* Make it take up the full height of the viewport */
}
.chat-box {
  width: 500px;
  margin: 0 auto;
  border: 1px solid #ccc;
  padding: 10px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.messages {
  max-height: 300px;
  overflow-y: auto;
  margin-bottom: 10px;
}
.message {
  margin-bottom: 5px;
}
.timestamp {
  font-size: 0.8em;
  color: #999;
}
.input-box {
  display: flex;
}
.input-box input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.input-box button {
  padding: 10px;
  margin-left: 5px;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 5px;
  cursor: pointer;
}
.input-box button:hover {
  background-color: #0056b3;
}
</style>
