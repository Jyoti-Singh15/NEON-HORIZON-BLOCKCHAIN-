// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { TicketNFT } from "../src/TicketNFT.sol";

contract TicketNFTTest is Test {
    TicketNFT public ticketContract;
    address public owner = address(1);
    address public user1 = address(2);
    address public user2 = address(3);

    function setUp() public {
        vm.prank(owner);
        ticketContract = new TicketNFT();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testBuyNormalTicket() public {
        vm.prank(user1);
        ticketContract.buyNormalTicket{value: 0.01 ether}();
        assertEq(ticketContract.balanceOf(user1), 1);
        assertEq(ticketContract.ticketTier(0), 1); 
    }

    function testBuyPremiumTicket() public {
        vm.prank(user2);
        ticketContract.buyPremiumTicket{value: 0.05 ether}();
        assertEq(ticketContract.balanceOf(user2), 1);
        assertEq(ticketContract.ticketTier(0), 2);
    }

    function testBuyNormalTicketNotEnoughEth() public {
        vm.prank(user1);   
       
        vm.expectRevert("Insufficient ETH for Normal Ticket");
        
        ticketContract.buyNormalTicket{value: 0.005 ether}();
    }

    function testWithdraw() public {
        vm.prank(user1);
        ticketContract.buyNormalTicket{value: 0.01 ether}();

        uint256 ownerBalanceBefore = owner.balance;
        
        vm.prank(owner);
        ticketContract.withdraw();

        uint256 ownerBalanceAfter = owner.balance;
        assertEq(ownerBalanceAfter - ownerBalanceBefore, 0.01 ether);
    }
}