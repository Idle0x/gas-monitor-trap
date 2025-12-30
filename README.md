# Void Catalyst Trap (Gas Monitor Trap)

**Status:** Live on Mainnet 🟢  
**Network:** Ethereum  
**Trap Address:** `0x1521a1C75cdeDC18d325ef430505d326A0646354`  
**Operator:** `0xcF75BeA7A11Eb0A764dC85DEf2F36c3ed826aE59`

## Overview
The **Void Catalyst** is a specialized security trap deployed on the Drosera Network. It acts as a "Network Congestion Monitor," protecting protocols from operating during periods of extreme gas volatility or spam attacks.

Instead of relying on centralized APIs to check gas prices, this trap uses decentralized Drosera operators to read the Ethereum execution layer's `block.basefee` directly from the block header in real-time.

## Operational Logic
* **Trigger Condition:** `block.basefee > 100 gwei`
* **Response:** Emits an on-chain `VoidDetected(uint256 gasPrice, uint256 timestamp)` event via the Responder contract.
* **State:** "Quiet" (Returns `false`) during normal network conditions to conserve operator resources.

## Technical Specifications
* **Type:** `ITrap` (Standard Drosera Interface)
* **Sample Size:** 1 Block (Real-time)
* **Gas Efficiency:** Optimized for < 300k gas deployment. 
* **External Calls:** 0 (Pure state reading)

## Directory Structure
* `src/VoidCatalystTrap.sol`: The logic contract monitoring `block.basefee`.
* `src/VoidCatalystResponse.sol`: The standard response contract used to signal alerts.
