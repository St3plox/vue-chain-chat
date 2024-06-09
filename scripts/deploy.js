import hardhat from 'hardhat';
const { ethers } = hardhat;

import { promises as fs } from 'fs';
import path from 'path';

async function main() {
  // We get the contract to deploy
  const Greeter = await ethers.getContractFactory("Message");
  const greeter = await Greeter.deploy();

  await greeter.deployed();

  const addressData = {
    address: greeter.address
  };

  // Write the address to a JSON file
  const filePath = path.resolve("contracts/cfg/message_contract.json");
  await fs.writeFile(filePath, JSON.stringify(addressData, null, 2));

  console.log("Greeter deployed to:", greeter.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
