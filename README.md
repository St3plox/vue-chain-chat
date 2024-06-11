# vue-chat

This project is created for learning purposes. It represents a simple web-based messenger built with Vue.js and Web3. It allows users to authenticate via MetaMask and send messages from their own addresses. The messages are stored on the Ethereum blockchain using a Solidity smart contract.


## Project Setup

```sh
npm install
```

### Run Development Server:

```sh
npm run dev
```

### Connect MetaMask:
Ensure that you have the MetaMask extension installed in your browser. Add your MetaMask account by importing it from Hardhat. To do this, follow these steps:

1) Run 
```sh
npx hardhat node
```
2) Copy one of the generated accounts' addresses from the console output.
3) Open MetaMask, click on the account icon, and select "Import Account".
4) Paste the address copied from the console into the import field.

### Connect to Testnet
1) In MetaMask, click on the network dropdown and select "Custom RPC".
2) Enter the testnet's RPC URL and chain ID. (Ussually 31337)
3) Click "Save" to connect to the testnet.

### Deploy Smart Contract
```sh
npx hardhat run scripts/deploy.js
```
### Interact with the Chat
Once the contract is deployed and MetaMask is connected to the appropriate network, you can interact with the chat application. Users can authenticate using MetaMask and send messages from their own addresses.

### Compile and Minify for Production

```sh
npm run build
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```
