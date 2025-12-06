# Drosera Mainnet Gas Monitor Trap ⛽

A live security trap deployed on Ethereum Mainnet that monitors network gas prices.

## 💡 Concept
This trap utilizes the Drosera Network to act as an automated "Gas Watchdog." It continuously checks `block.basefee` on Ethereum Mainnet. If the gas price drops below a specific target (20 gwei), it triggers an on-chain alert.

This logic serves as a foundational template for more complex monitoring systems, such as detecting oracle anomalies or timing transaction executions for low-cost periods.

## 📍 Mainnet Deployment Details
* **Trap Logic Address:** `0xB400bC781d57aa26592940b31f5967bA015a7df6`
* **Trap Config Address:** `0x1521a1C75cdeDC18d325ef430505d326A0646354`
* **RPC Endpoint:** Ankr Premium/Freemium

## 🛠 How It Works
1. **Collect:** The trap reads `block.basefee` from the current block.
2. **Analyze:** It compares the current fee against the `TARGET_GAS` threshold.
3. **Respond:** If conditions are met, it executes the response logic (emitting an event).

## 🚀 Operator Setup
This trap is powered by a Drosera Operator Node running via Docker on a Linux VPS.
```
