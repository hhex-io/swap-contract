<h1 align="center"> Hand to Hand Exchange: Swap </h1>
Exchange `x NFT` for `y NFT` without payment (except for gas & platform fees).

## Use Case

Alice wants to exchange her NFT for Bob's. 1 NFT can be exchanged for 1 NFT.

### Process

Alice signs a tx to exchange her `x NFT` for Bob's `y NFT` and gives approval to `Swap` contract to process the exchange. Bob verifies the NFTs in the dApp interface. If approved, he signs an approval for the echange, grants the rights to `Swap` to process the swap and publishes the whole tx on-chain. The NFTs are exchanged.

Note:

-   Publishing and decoding the signature on-chain can fail if:
    -   One party no longer owns the NFT
    -   One party lacks funds for the platform or gas fees
    -   The signature timestamp is too old
    -   One party has not signed

## Implementation

-   Frontend dApp checks before signature:
    -   NFT ownership
    -   Funds for the platform and gas fees
-   First signature is saved in the backend
-   Second signature pushes both signatures on-chain
-   Swap contract:
    -   Decodes both signatures
    -   Processes the NFT exchange
    -   Take platform fee

## Later

-   Use `Permit2` instead `IERC712.approve(...)`
-   Add platform fee
-   Exchange one to many, many to many...
-   Both parties can issue the transaction
-   ERC20 payment can be introduced during the exchange
-   Platform fee is taken on both sides (encoded in the signature)

## Deployed Contracts

-   v0.1.0 - bsc testnet: [0x8d67dF98c25e202066230cDBaC17D199eEeF53F6](https://testnet.bscscan.com/address/0x8d67df98c25e202066230cdbac17d199eeef53f6)
    -   users must approve swap contract with either `approve(address(swap), id)` or `setApprovalForAll(address(swap), true)`
