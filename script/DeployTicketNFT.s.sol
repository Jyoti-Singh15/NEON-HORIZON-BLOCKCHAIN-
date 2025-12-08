// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script, console } from "forge-std/Script.sol";
import { TicketNFT } from "../src/TicketNFT.sol";

contract DeployTicketNFT is Script {
    function run() external {
        vm.startBroadcast();

        TicketNFT ticket = new TicketNFT();
        console.log("Contract Deployed to:", address(ticket));

        vm.stopBroadcast();
    }
}