userland@localhost:~/Sovereign-Titan-Genesis/stg-chain$ npx hardhat console --network localhost
Welcome to Node.js v22.22.2.
Type ".help" for more information.
> const AKSA = await ethers.getContractFactory("AKSA");
undefined
>
> const aksa = await AKSA.attach(
... "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"
... );
undefined
>
> (await aksa.name())
'Aksa Kedaulatan Sovereign Asset'
> (await aksa.symbol())
'AKSA'
> (await aksa.totalSupply()).toString()
'1498000000000000000000000000000'
>
