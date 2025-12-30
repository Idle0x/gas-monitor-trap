// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract VoidCatalystTrap is ITrap {
    // TRIGGER: Alert if gas spikes above 100 gwei (Network Congestion/Spam)
    uint256 public constant SPIKE_THRESHOLD = 100 gwei;

    function collect() external view override returns (bytes memory) {
        return abi.encode(block.basefee);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // SAFETY: Planner Guard
        if (data.length == 0 || data[0].length == 0) {
            return (false, bytes(""));
        }

        // Decode newest block
        uint256 currentGas = abi.decode(data[0], (uint256));

        // LOGIC: Check for Gas Spike
        if (currentGas > SPIKE_THRESHOLD) {
            return (true, abi.encode(currentGas));
        }

        return (false, bytes(""));
    }
}
