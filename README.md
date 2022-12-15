# Kwenta Margin Manager

Contracts to manage account abstractions and features on top of Synthetix Perps v2. This will support implementations of cross margin, limit orders, and stop orders.

## Folder Structure

    ├── ...
    ├── src                     # Source contracts
    ├── script                  # Foundry deployment scripts
    ├── test                    # Test files (alternatively `spec` or `tests`)
    │   ├── contracts           # Unit tests, fuzz tests using Foundry
    │   └── integration         # End-to-end, integration tests using Foundry
    └── ...

## Interacting

Make sure the deployer private key is set as an ENV if you want to use a signer
```
DEPLOYER_PRIVATE_KEY=0xYOUR_PRIVATE_KEY
```

## Testing

### Running Tests
1. Follow the [Foundry guide to working on an existing project](https://book.getfoundry.sh/projects/working-on-an-existing-project.html)

2. Build project
```
forge build
```
3. Execute unit tests
```
npm run test
```
