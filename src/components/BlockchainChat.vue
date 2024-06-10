<template>
  <div>
    <div>
      <h2>Messages</h2>
      <ul>
        <li v-for="(message, index) in messages" :key="index">
          <p><strong>Sender:</strong> {{ message.sender }}</p>
          <p><strong>Message:</strong> {{ message.text }}</p>
        </li>
      </ul>
    </div>
    <div>
      <p>Message is: {{ newMessage }}</p>
      <textarea v-model="newMessage" placeholder="Add multiple lines"></textarea>
      <button @click="handleSubmit">Submit</button>
      <p>Contract deployed to: {{ contractAddress }}</p>
    </div>
  </div>
</template>

<script setup>
import { ethers } from 'ethers'
import { onMounted, ref } from 'vue'

// Define contract address and ABI
const contractAddress = ref('')
const contractABI = ref([])

const newMessage = ref('')
const messages = ref([])

const requestAccess = async () => {
  if (window.ethereum) {
    try {
      await window.ethereum.request({ method: 'eth_requestAccounts' })
    } catch (error) {
      console.error('User denied account access:', error)
    }
  } else {
    console.error('MetaMask is not installed')
  }
}

const handleSubmit = async () => {
  try {
    if (!window.ethereum) throw new Error('MetaMask is not installed')

    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const signer = provider.getSigner()
    const contract = new ethers.Contract(contractAddress.value, contractABI.value, signer)

    await contract.post(newMessage.value)
    console.log('Message submitted:', newMessage.value)

    newMessage.value = ''
    await fetchMessages()
  } catch (error) {
    console.error('Error submitting message:', error)
  }
}

const fetchMessages = async () => {
  try {
    if (!window.ethereum) throw new Error('MetaMask is not installed')

    const response = await fetch('contracts/cfg/message_contract.json')
    const fetchData = await response.json()

    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const abi = fetchData.abi
    const address = fetchData.address
    const contract = new ethers.Contract(address, abi, provider)

    console.log('Address trying to access', address)
    const messagesArray = await contract.getAllMessages()

    messages.value = messagesArray
  } catch (error) {
    console.error('Error fetching messages:', error)
  }
}

onMounted(async () => {
  await requestAccess()

  try {
    const response = await fetch('contracts/cfg/message_contract.json')
    const data = await response.json()

    contractAddress.value = data.address
    contractABI.value = data.abi

    console.log('Contract deployed to:', data.address)

    await fetchMessages()
  } catch (error) {
    console.error('Error fetching contract details:', error)
  }
})
</script>
