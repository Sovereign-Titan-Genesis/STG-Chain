import { createDid } from './did';

async function main() {
  const pubKeyHex = "abcd1234...";
  const controller = "stg1xyz...";
  const { did, doc } = await createDid(pubKeyHex, controller);
  console.log("Created DID:", did);
  console.log("DID Document:", doc);
}

main();
