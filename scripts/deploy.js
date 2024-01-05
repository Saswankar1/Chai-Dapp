// const fs = require("fs")

async function main() {
    const Voting = await ethers.getContractFactory("Voting")
    const voting = await Voting.deploy()

    await voting.deployed()

    console.log("voting deployed to:", await voting.getAddress())

    // const data = {
    //     address: voting.address,
    //     abi: JSON.parse(voting.interface.format("json")),
    // }

    //writes the ABI and address to the voting.json
    // fs.writeFileSync("./src/voting.json", JSON.stringify(data))
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
