// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {
    OPTIMISM_GOERLI_SYNTHETIX_ADDRESS_RESOLVER,
    OPTIMISM_GOERLI_FACTORY,
    OPTIMISM_GOERLI_GELATO,
    OPTIMISM_GOERLI_OPS,
    OPTIMISM_GOERLI_SETTINGS
} from "../../utils/parameters/OptimismGoerliParameters.sol";
import {
    OPTIMISM_SYNTHETIX_ADDRESS_RESOLVER,
    OPTIMISM_FACTORY,
    PROXY_SUSD,
    PERPS_V2_EXCHANGE_RATE,
    FUTURES_MARKET_MANAGER,
    SYSTEM_STATUS,
    OPTIMISM_GELATO,
    OPTIMISM_OPS,
    OPTIMISM_SETTINGS
} from "../../utils/parameters/OptimismParameters.sol";
import {Account} from "src/Account.sol";
import {Events} from "src/Events.sol";
import {IAddressResolver} from "../../utils/interfaces/IAddressResolver.sol";

/// @title Script to upgrade the Account implementation v2.0.1 -> v2.0.1
/// @author JaredBorders (jaredborders@pm.me)

/// @dev steps to deploy and verify on Optimism:
/// (1) load the variables in the .env file via `source .env`
/// (2) run `forge script script/upgrades/v2.0.2/Upgrade.s.sol:UpgradeAccountOptimism --rpc-url $ARCHIVE_NODE_URL_L2 --broadcast --verify -vvvv`
/// (3) Smart Margin Account Factory owner (i.e. Kwenta pDAO) will need to call `upgradeAccountImplementation` on the Factory with the address of the new Account implementation
contract UpgradeAccountOptimism is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        upgrade();

        vm.stopBroadcast();
    }

    function upgrade() public returns (address implementation) {
        IAddressResolver addressResolver =
            IAddressResolver(OPTIMISM_SYNTHETIX_ADDRESS_RESOLVER);

        // deploy events
        address events = address(new Events({_factory: OPTIMISM_FACTORY}));

        address marginAsset = addressResolver.getAddress({name: PROXY_SUSD});
        address perpsV2ExchangeRate =
            addressResolver.getAddress({name: PERPS_V2_EXCHANGE_RATE});
        address futuresMarketManager =
            addressResolver.getAddress({name: FUTURES_MARKET_MANAGER});
        address systemStatus = addressResolver.getAddress({name: SYSTEM_STATUS});

        implementation = address(
            new Account({
                _factory: OPTIMISM_FACTORY,
                _events: events,
                _marginAsset: marginAsset,
                _perpsV2ExchangeRate: perpsV2ExchangeRate,
                _futuresMarketManager: futuresMarketManager,
                _systemStatus: systemStatus,
                _gelato: OPTIMISM_GELATO,
                _ops: OPTIMISM_OPS,
                _settings: OPTIMISM_SETTINGS
            })
        );
    }
}

/// @dev steps to deploy and verify on Optimism Goerli:
/// (1) load the variables in the .env file via `source .env`
/// (2) run `forge script script/upgrades/v2.0.2/Upgrade.s.sol:UpgradeAccountOptimismGoerli --rpc-url $ARCHIVE_NODE_URL_GOERLI_L2 --broadcast --verify -vvvv`
/// (3) Smart Margin Account Factory owner (i.e. Kwenta pDAO) will need to call `upgradeAccountImplementation` on the Factory with the address of the new Account implementation
contract UpgradeAccountOptimismGoerli is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        upgrade();

        vm.stopBroadcast();
    }

    function upgrade() public returns (address implementation) {
        IAddressResolver addressResolver =
            IAddressResolver(OPTIMISM_GOERLI_SYNTHETIX_ADDRESS_RESOLVER);

        // deploy events
        address events =
            address(new Events({_factory: OPTIMISM_GOERLI_FACTORY}));

        address marginAsset = addressResolver.getAddress({name: PROXY_SUSD});
        address perpsV2ExchangeRate =
            addressResolver.getAddress({name: PERPS_V2_EXCHANGE_RATE});
        address futuresMarketManager =
            addressResolver.getAddress({name: FUTURES_MARKET_MANAGER});
        address systemStatus = addressResolver.getAddress({name: SYSTEM_STATUS});

        implementation = address(
            new Account({
                _factory: OPTIMISM_GOERLI_FACTORY,
                _events: events,
                _marginAsset: marginAsset,
                _perpsV2ExchangeRate: perpsV2ExchangeRate,
                _futuresMarketManager: futuresMarketManager,
                _systemStatus: systemStatus,
                _gelato: OPTIMISM_GOERLI_GELATO,
                _ops: OPTIMISM_GOERLI_OPS,
                _settings: OPTIMISM_GOERLI_SETTINGS
            })
        );
    }
}
