import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('Swap', function () {
    /*//////////////////////////////////////////////////////////////
                                 BASIC ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    it('Should return name Swap', async function () {
        const Swap = await ethers.getContractFactory('Swap');
        const token = await Swap.deploy();
        await token.deployed();

        expect(await token.name()).to.equal('Swap');
    });
});
