// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract VoidCatalystTrap is ITrap {
    // 20 gwei trigger
    uint256 public constant VOID_THRESHOLD = 20 gwei;

    function collect() external view returns (bytes memory) {
        return abi.encode(block.basefee);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        // SAFETY 1: Check if data exists
        if (data.length == 0) return (false, bytes(""));
        
        // SAFETY 2: Check if the latest sample is valid
        // We only care about the freshest data (index 0 usually, but let's check the last one added)
        // Drosera usually sends [oldest ... newest]. Let's check the newest.
        bytes memory latestData = data[data.length - 1];
        if (latestData.length == 0) return (false, bytes(""));

        uint256 currentGas = abi.decode(latestData, (uint256));

        if (currentGas < VOID_THRESHOLD) {
            // MATCH: Return true and pass the gas price to the responder
            return (true, abi.encode(currentGas));
        }

        return (false, bytes(""));
    }
}
