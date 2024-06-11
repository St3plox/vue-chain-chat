import hardhat from 'hardhat'
const { ethers } = hardhat
import { promises as fs } from 'fs'
import path from 'path'

async function main() {
  // Get the contract to deploy
  const Greeter = await ethers.getContractFactory('Message')
  const greeter = await Greeter.deploy()

  await greeter.deployed()

  // Save the contract address and ABI to a file
  const contractData = {
    address: greeter.address,
    abi: JSON.parse(greeter.interface.format('json'))
  }

  // Write the address and ABI to a JSON file
  const filePath = path.resolve('src/components/contracts/cfg/message_contract.json')
  await fs.writeFile(filePath, JSON.stringify(contractData, null, 2))

  console.log('Greeter deployed to:', greeter.address)
}

main().catch((error) => {
  console.error(error)
})
