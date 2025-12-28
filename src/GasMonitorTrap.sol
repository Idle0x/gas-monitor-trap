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

        // SAFETY 2: Check if the LATEST sample (index 0) is valid
        if (data[0].length == 0) return (false, bytes(""));

        // DECODE: data[0] is the newest block data
        uint256 currentGas = abi.decode(data[0], (uint256));

        if (currentGas < VOID_THRESHOLD) {
            // MATCH: Return true and pass the gas price to the responder
            // This matches executeIgnition(uint256)
            return (true, abi.encode(currentGas));
        }

        return (false, bytes(""));
    }
}
