// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    address public liquidityWallet;
    address public treasuryWallet;
    uint256 public royaltyFee = 10; // 10% royalty fee

    constructor(address _liquidityWallet, address _treasuryWallet) ERC721("MyNFT", "MNFT") Ownable(_msgSender()) {
        tokenCounter = 0;
        liquidityWallet = _liquidityWallet;
        treasuryWallet = _treasuryWallet;
    }

    function mintNFT(address recipient, string memory tokenURI, uint256 price) public onlyOwner returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter++;

        // Calculate royalty fee
        uint256 royaltyAmount = (price * royaltyFee) / 100;
        uint256 treasuryAmount = (royaltyAmount * 6) / 10; // 60% of royalty to treasury
        uint256 liquidityAmount = royaltyAmount - treasuryAmount; // 40% of royalty to liquidity

        // Transfer royalty to wallets
        require(royaltyAmount > 0, "Royalty fee must be greater than zero");
        require(treasuryAmount + liquidityAmount == royaltyAmount, "Invalid royalty split");

        // Transfer to liquidity wallet
        if (liquidityAmount > 0) {
            _transfer(address(this), liquidityWallet, liquidityAmount);
        }

        // Transfer to treasury wallet
        if (treasuryAmount > 0) {
            _transfer(address(this), treasuryWallet, treasuryAmount);
        }

        return newTokenId;
    }
}