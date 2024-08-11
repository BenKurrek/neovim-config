const nearAPI = require("near-api-js");
const { KeyPair, keyStores } = nearAPI;
const prompt = require("prompt-sync")();
const readline = require("readline-sync");
const nearSeedPhrase = require("near-seed-phrase");
const { parseSeedPhrase } = nearSeedPhrase;

const main = async () => {
  const network = "testnet";
  const path = require("path");
  const homedir = require("os").homedir();

  const CREDENTIALS_DIR = ".near-credentials";
  const credentialsPath = path.join(homedir, CREDENTIALS_DIR);
  const keyStore = new keyStores.UnencryptedFileSystemKeyStore(credentialsPath);

  // Prompt for account ID and private key
  const accountId = readline.question("Enter your NEAR account ID: ");
  const privateKey = readline.question("Enter your NEAR private key: ");
  let keyPair;
  try {
    keyPair = KeyPair.fromString(privateKey);
  } catch (e) {
    const { secretKey } = parseSeedPhrase(privateKey);
    keyPair = KeyPair.fromString(secretKey);
  }

  await keyStore.setKey(network, accountId, keyPair);

  console.log(`Key set for account ${accountId}`);
};

main().catch((err) => {
  console.error(err);
});
