// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@thirdweb-dev/contracts/prebuilts/account/utils/BaseAccountFactory.sol";
import "./CustomAccount.sol";


contract CustomAccountFactory is BaseAccountFactory {

    event CustomAccountCreated(address indexed account, string indexed username);
    mapping (string => address) usernameToAccount;

    constructor(
        IEntryPoint _entryPoint
    ) BaseAccountFactory(
        address(new CustomAccount(_entryPoint, address(this))),
        address(_entryPoint)
    ) {}

    function _initializeAccount(address account, address _admin, bytes calldata _data) internal override {
        CustomAccount(payable(account)).initialize(_admin, _data);
    }

    function onRegistered(
        string calldata _username
    )
    external
    {
        address account = msg.sender;
        require(this.isRegistered(account), "BaseCustomAccountFactory: account not registered");
        require(usernameToAccount[_username] == address(0), "BaseCustomAccountFactory: username already taken");
        usernameToAccount[_username] = account;
        emit CustomAccountCreated(account, _username);   
    }

}