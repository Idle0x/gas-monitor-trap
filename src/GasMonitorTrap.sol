// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract GasMonitorTrap is ITrap {
    // We want to trigger if gas is CHEAP (e.g., below 20 gwei)
    // 20 gwei = 20000000000 wei
    uint256 public constant TARGET_GAS = 20 gwei;

    function collect() external view returns (bytes memory) {
        // Collect the current block's base fee
        return abi.encode(block.basefee);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        // Decode the collected gas price
        uint256 currentGas = abi.decode(data[0], (uint256));

        // Trigger if current gas is LOWER than our target (Cheap Gas Alert!)
        if (currentGas < TARGET_GAS) {
            return (true, abi.encode(currentGas));
        }

        return (false, bytes(""));
    }

    // This function will emit a log on-chain when gas is cheap
    event LowGasDetected(uint256 gasPrice);

    function respond(bytes[] calldata data) external {
        uint256 currentGas = abi.decode(data[0], (uint256));
        emit LowGasDetected(currentGas);
    }
}
