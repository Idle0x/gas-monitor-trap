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
        // SAFETY 1: Planner Guard
        // Drosera sends an array of historical data. We must ensure it's not empty.
        // Also check data[0] (the newest block) is not empty bytes.
        if (data.length == 0 || data[0].length == 0) {
            return (false, bytes(""));
        }

        // SAFETY 2: Valid Decode
        // decode data[0] because it is the most recent block's data
        uint256 currentGas = abi.decode(data[0], (uint256));

        if (currentGas < VOID_THRESHOLD) {
            // MATCH: Return true and pass the single uint256 to the responder
            // This MUST match executeIgnition(uint256) signature
            return (true, abi.encode(currentGas));
        }

        return (false, bytes(""));
    }
}
