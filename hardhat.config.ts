import fs from 'fs';
import '@nomiclabs/hardhat-waffle';
import '@typechain/hardhat';
import 'hardhat-preprocessor';
import { HardhatUserConfig, task } from 'hardhat/config';
import '@nomiclabs/hardhat-etherscan';

// use .env vars
import * as dotenv from 'dotenv';
dotenv.config();

// import example from './tasks/example';

function getRemappings() {
    return fs
        .readFileSync('remappings.txt', 'utf8')
        .split('\n')
        .filter(Boolean)
        .map((line) => line.trim().split('='));
}

// task('example', 'Example task').setAction(example);

const config: HardhatUserConfig = {
    networks: {
        goerli: {
            url: process.env.GOERLI_RPC_URL,
            accounts: {
                mnemonic: process.env.SEED,
            },
        },
        bsc: {
            url: 'https://bsc-dataseed.binance.org',
            accounts: {
                mnemonic: process.env.SEED,
            },
        },
        bscTest: {
            url: 'https://data-seed-prebsc-1-s1.binance.org:8545',
            accounts: {
                mnemonic: process.env.SEED,
            },
        },
        celo: {
            url: process.env.CELO_MAINNET,
            accounts: { mnemonic: process.env.SEED },
        },
    },
    etherscan: {
        apiKey: {
            bsc: process.env.BSC_SCAN_KEY ?? '',
            celo: process.env.CELO_SCAN_KEY ?? '', // mainnet
        },
    },
    solidity: {
        version: '0.8.13',
        settings: {
            optimizer: {
                enabled: true,
                runs: 200,
            },
        },
    },
    paths: {
        sources: './src', // Use ./src rather than ./contracts as Hardhat expects
        cache: './cache_hardhat', // Use a different cache for Hardhat than Foundry
    },
    // This fully resolves paths for imports in the ./lib directory for Hardhat
    preprocess: {
        eachLine: (hre) => ({
            transform: (line: string) => {
                if (line.match(/^\s*import /i)) {
                    getRemappings().forEach(([find, replace]) => {
                        if (line.match(find)) {
                            line = line.replace(find, replace);
                        }
                    });
                }
                return line;
            },
        }),
    },
};

export default config;
