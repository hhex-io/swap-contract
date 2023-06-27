const { ethers } = require('ethers');

/**
 * Same data to be signed by both parties to make the exchange
 *
 * @param {ethers.Wallet} signer - Wallet instance
 *
 * @param {Object} domain - Domain of `EIP712`
 * @param {string} domain.name - Name passed in EIP712 constructor
 * @param {string} domain.version - Version passed in EIP712 constructor
 * @param {ethers.BigNumber} domain.chaindId - Chain id where the contract is deployed
 * @param {string} domain.contractAddr - Address of the contract
 *
 * @param {Object} exchange - Defined in interface {src/ISwapInternal.sol}
 */

async function signExchange(signer, domain, exchange) {
    const types = {
        Data: [
            { type: 'address', name: 'nft' },
            { type: 'uint256', name: 'nftId' },
            { type: 'address', name: 'to' },
        ],
        Exchange: [
            { type: 'Data', name: 'partyOne' },
            { type: 'Data', name: 'partyTwo' },
            { type: 'uint256', name: 'deadline' },
            { type: 'uint256', name: 'id' },
        ],
    };

    return await signer._signTypedData(domain, types, {
        ...exchange,
    });
}

module.exports = { signExchange };

////////// Signer example //////////
// const wallet = new ethers.Wallet.fromMnemonic(process.env.SEED);

////////// Domain example //////////
/* const domain = {
    name: 'Hand 2 Hand Exchange',
    version: '1',
    chainId: ethers.BigNumber.from('97'),
    verifyingContract: '0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990', // swap contract
}; */

////////// Exchange example //////////
/*
const exchange = {
    partyOne: {
        nft: '0x326374475908FC640C3DDE59981C721CafF9c828', // WincityPGC
        nftId: 1,
        to: '0x1f9090aaE28b8a3dCeaDf281B0F12828e676c326',
    },
    partyTwo: {
        nft: '0x326374475908FC640C3DDE59981C721CafF9c828',  // WincityPGC
        nftId: 20,
        to: '0xE94f1fa4F27D9d288FFeA234bB62E1fBC086CA0c',
    },
    deadline: 1627776000,
    id: 234189124 // random id to define an exchange
}
*/
