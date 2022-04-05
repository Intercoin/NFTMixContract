// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

//import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts-upgradeable/utils/structs/EnumerableSetUpgradeable.sol";
// import "../interfaces/IFactory.sol";

// import "./INFTInstanceContract.sol";
// import "./NFTState.sol";
// import "./NFTView.sol";

//import "../submodules/NonFungibleTokenContract/contracts/interfaces/ICostManager.sol";

//import "../interfaces/INFTremix.sol";
interface INFTremix {
    struct PairData {
        address contractAddress;
        uint64 seriesId;
        
    }
    
    function ownerOf(address tokenAddress, uint256 tokenId) external view returns(address);
    function fork(PairData memory fromRemixData, PairData memory newRemixData, bytes memory payload) external;


}
////////////////////////////////////////
//

import "@openzeppelin/contracts-upgradeable/utils/structs/EnumerableSetUpgradeable.sol";

contract NFTremix is INFTremix/*Ownable, ICostManager, IFactory*/ {

    using EnumerableSetUpgradeable for EnumerableSetUpgradeable.UintSet;

    uint8 internal constant SERIES_SHIFT_BITS = 192; // 256 - 64
    struct Data {
        PairData pairData;
        bool exists;
        EnumerableSetUpgradeable.UintSet parents;
        EnumerableSetUpgradeable.UintSet childs;
    }
    
    mapping(uint256 => Data) data;
    mapping(bytes32 => uint256) internal pairIndex;
    

    function ownerOf(address tokenAddress, uint256 tokenId) external view returns(address) {
        // TODO 0: implement
        return address(0);
    }

    function fork(PairData memory fromRemixData, PairData memory newRemixData, bytes memory payload) external {
        uint256 fromRemixDataIndex = pairIndex[_getIndexPair(fromRemixData.contractAddress, fromRemixData.seriesId)];
        require(fromRemixDataIndex != 0);
        uint256 toRemixDataIndex = pairIndex[_getIndexPair(newRemixData.contractAddress, newRemixData.seriesId)];
        require(!data[fromRemixDataIndex].childs.contains(toRemixDataIndex));

        // TODO: 0 checking payload
        //require(validatePayload())

        // store
        if (data[toRemixDataIndex].exists == false) {
            data[toRemixDataIndex].pairData.contractAddress = newRemixData.contractAddress;
            data[toRemixDataIndex].pairData.seriesId = newRemixData.seriesId;
        }

        data[fromRemixDataIndex].childs.add(toRemixDataIndex);


        //require (toRemixDataIndex != 0);
        //data[keccak256(abi.encodePacked(fromRemixData.contractAddress, fromRemixData.seriesId))].add(1);

    }








    function _getIndexPair(address contractAddress, uint64 seriesId) internal pure returns(bytes32) {
        return keccak256(abi.encodePacked(contractAddress, seriesId));
    }
    // function _createFork(address contractAddress, uint64 seriesId) {
    //     if (data[toRemixDataIndex].exists == false) {
    //         data[toRemixDataIndex].pairData.contractAddress = newRemixData.contractAddress;
    //         data[toRemixDataIndex].pairData.seriesId = newRemixData.seriesId;
    //     }
    // }


    function getTokenIndex(
        uint256 tokenId
    )
        internal
        pure
        returns(uint192)
    {
        return uint192(tokenId - (getSeriesId(tokenId) << SERIES_SHIFT_BITS));
    }

    function getSeriesId(
        uint256 tokenId
    )
        internal
        pure
        returns(uint64)
    {
        return uint64(tokenId >> SERIES_SHIFT_BITS);
    }
}