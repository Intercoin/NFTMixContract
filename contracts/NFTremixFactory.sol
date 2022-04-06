// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "./interfaces/INFTremixInstanceContract.sol";
import "./NFTremix.sol";
import "../submodules/NonFungibleTokenContract/contracts/v2/NFTFactory.sol";

contract NFTremixFactory is NFTFactory {
//     using EnumerableSetUpgradeable for EnumerableSetUpgradeable.AddressSet;
    
//     address public implementation;
//     //mapping(bytes32 => address) public getInstance; // keccak256("name", "symbol") => instance address
//     //mapping(address => InstanceInfo) private _instanceInfos;
//     address[] public instances;
       
//     // struct InstanceInfo {
//     //     address NFTFactory
//     //     string symbol;
//     //     address creator;
//     // }
    
//     event InstanceCreated(address instance, uint256 length);

    NFTremix public immutable instanceNFTremix;

    constructor (
        address instance, 
        address costManager_
    ) NFTFactory(instance, costManager_) {
        instanceNFTremix = new NFTremix();
    }

    function _produce(
        string memory name,
        string memory symbol,
        string memory contractURI,
        string memory baseURI,
        string memory suffixURI

    ) 
        internal 
        virtual
        override
        returns (address instance) 
    {
        _createInstanceValidate(name, symbol);
        address instanceCreated = _createInstance(name, symbol);
        require(instanceCreated != address(0), "StakingFactory: INSTANCE_CREATION_FAILED");
        address ms = _msgSender();
        INFTremixInstanceContract(instanceCreated).initialize(
            address(implementationNFTState),
            address(implementationNFTView),
            name, 
            symbol, 
            contractURI, 
            baseURI,
            suffixURI,
            costManager, 
            ms,
            address(instanceNFTremix)

        );
        Ownable(instanceCreated).transferOwnership(ms);
        instance = instanceCreated;
    }


       
}
