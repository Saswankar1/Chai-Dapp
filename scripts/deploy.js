// const fs = require("fs")

async function main() {
    const Chai = await ethers.getContractFactory("Chai"); // fetching bytecode and ABI
    const chai = await Chai.deploy(); // creating an instance of our smart contract

    await chai.deployed() // deploying smart contract

    console.log("Chai deployed to:", `${chai.address}`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
