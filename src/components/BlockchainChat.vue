<script setup>
import { ref } from 'vue';

// Initialize the message variable
const message = ref("default message");


// Fetch the deployed contract address
const gtAddress = ref("");

fetch('contracts/cfg/message_contract.json')
    .then(response => response.json())
    .then(data => {
        gtAddress.value = data.address;
        console.log("Greeter deployed to:", data.address);
    })
    .catch(error => console.error('Error fetching contract address:', error));



// Function to handle button click
const handleSubmit = () => {
    console.log("Submitted message:", message.value);
    console.log('Link clicked!');
    console.log('Greeter deployed to ', gtAddress.value);
};

</script>

<template>
    <div>
        <p>Message is: {{ message }}</p>
        <textarea v-model="message" placeholder="add multiple lines"></textarea>
        <button @click="handleSubmit">Submit</button>
        <p>Greeter deployed to: {{ gtAddress }}</p>
    </div>
</template>
