// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VoidCatalystResponse {
    event VoidDetected(uint256 indexed gasPrice, uint256 timestamp);

    // FIX: Typed argument matches exactly what the trap encodes
    function executeIgnition(uint256 gasPrice) external {
        emit VoidDetected(gasPrice, block.timestamp);
    }
}
