// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract TicketNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    
    uint256 public constant NORMAL_PRICE = 0.0001 ether;
    uint256 public constant PREMIUM_PRICE = 0.005 ether;

    mapping(uint256 => uint256) public ticketTier; 

    constructor() ERC721("SepoliaEvent", "SEVT") Ownable(msg.sender) {}

    function buyNormalTicket() external payable {
        require(msg.value >= NORMAL_PRICE, "Insufficient ETH for Normal Ticket");
        _mintTicket(msg.sender, 1);
       
        (bool success, ) = payable(owner()).call{value: msg.value}("");
        require(success, "Transfer to owner failed");
    }

    function buyPremiumTicket() external payable {
        require(msg.value >= PREMIUM_PRICE, "Insufficient ETH for Premium Ticket");
        _mintTicket(msg.sender, 2);
        
        (bool success, ) = payable(owner()).call{value: msg.value}("");
        require(success, "Transfer to owner failed");
    }

    function _mintTicket(address to, uint256 tier) internal {
        uint256 tokenId = nextTokenId++;
        ticketTier[tokenId] = tier;
        _safeMint(to, tokenId);
    }

  
}
