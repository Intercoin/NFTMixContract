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
        EnumerableSetUpgradeable.UintSet parentPairIndexes;
        bool hasChilds; // bool forked; means already forked
        bool hasTokens; // filled when contract
        //EnumerableSetUpgradeable.UintSet childs;
    }
    //           (2#1,3#1)  
    // 1#1->1#2->(1#3)     ->1#4->1#5
    //           (2#1,3#1) ->1#6       ->1#7


    mapping(uint256 => Data) data;
    mapping(bytes32 => uint256) internal pairsIndexes;
    uint256 pairIndexCounter;
    
    constructor() {
        pairIndexCounter = 1; // 0 - reserved for none exists key. 1- it is next key that used to store
    }

    function ownerOf(address tokenAddress, uint256 tokenId) external view returns(address) {
        // TODO 0: implement
        return address(0);
    }

    function fork(PairData memory fromRemixData, PairData memory newRemixData, bytes memory payload) external {
        // ---- fromRemixData ----
        // get parent indexPair
        uint256 fromRemixDataIndex = pairIndex[_getIndexPair(fromRemixData.contractAddress, fromRemixData.seriesId)];

        // create if have not exists yet
        if (fromRemixDataIndex == 0) {
            fromRemixDataIndex = pairIndexCounter;
            pairIndexCounter += 1;
            // 
            data[fromRemixDataIndex].pairData.contractAddress = fromRemixData.contractAddress;
            data[fromRemixDataIndex].pairData.seriesId = fromRemixData.seriesId;
        }
        // can approve fork unless tokens exists in contract=`fromRemixData.contractAddress` with seriesID=`fromRemixData.seriesId`
        // otherwise you have to create another virtual tokens for ALL child contracts and series 
        require(data[fromRemixDataIndex].hasTokens == false);

        // mark that series have fork
        data[fromRemixDataIndex].hasChilds = true;

        // ---- toRemix ----
        // get child indexPair
        uint256 toRemixDataIndex = pairIndex[_getIndexPair(newRemixData.contractAddress, newRemixData.seriesId)];
        // create if have not exists yet
        if (toRemixDataIndex == 0) {
            toRemixDataIndex = pairIndexCounter;
            pairIndexCounter += 1;
            // 
            data[toRemixDataIndex].pairData.contractAddress = newRemixData.contractAddress;
            data[toRemixDataIndex].pairData.seriesId = newRemixData.seriesId;
        }

        // new created pair should not have tokens and can not be forked
        require(data[toRemixDataIndex].hasTokens == false && data[toRemixDataIndex].hasChilds == false);

        // finally actualize parentPairIds
        for(uint256 i = 0; i < data[fromRemixDataIndex].parentPairIndexes.length(); i++) {
            data[toRemixDataIndex].parentPairIndexes.add(data[fromRemixDataIndex].parentPairIndexes.at(i));
        }
        
        validatePayload();

    }

    function _getPairIndex(address contractAddress, uint256 seriesId) returns(uint256 dataIndex) {
        bytes32 pairIdent = keccak256(abi.encodePacked(contractAddress, seriesId));
        dataIndex = pairIndex[pairIdent];

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

    //function makeTree

    function validatePayload() internal {
        // TODO: 0 checking payload
        // checks:
        // 1. payload signed by author fromRemixPair
        // 2. payload haven't used yet(in newRemixData parent key should not contain fromRemixData )
        // 3. correct domain
        // 4. 
        // 
    }
}