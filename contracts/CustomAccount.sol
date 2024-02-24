// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "@thirdweb-dev/contracts/prebuilts/account/non-upgradeable/Account.sol";
import "./CustomAccountFactory.sol";

contract CustomAccount is Account {

    constructor(
        IEntryPoint _entryPoint,
        address factory
    ) Account(_entryPoint, factory) {
        _disableInitializers();
    }

    function register(
        string calldata _username,
        string calldata _metadataURI
    ) external {
        require(msg.sender == address(this), "CustomAccount: only account can register");
        CustomAccountFactory(factory).onRegistered(_username);
        _setupContractURI(_metadataURI);
    }

}

