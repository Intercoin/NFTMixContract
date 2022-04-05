// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "../submodules/NonFungibleTokenContract/contracts/v2/NFTMain.sol";

abstract contract NFTRemixChild {
//     function fork(parentSeriesId, childSeriesId, SeriesInfo, signature)
    address remixContract;
    bool remixContractSetup;

    event RemixSetup(address addr);

    modifier runOnlyOnce() {
        require(remixContractSetup == false, "only once");
        remixContractSetup = true;
        _;
    }
    function setRemixContract(address remixContract_) public runOnlyOnce {
        remixContract = remixContract_;
    }

    function _buy(uint256 tokenId) internal {
        // TODO 0: implement creation tree of parent tokens

        //calculate funds need to pay for all tokens
        
    }



}

//
contract NFT is NFTMain, NFTRemixChild {
     /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     * @custom:calledby everyone
     * @custom:shortd owner address by token id
     */

    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = super.ownerOf(tokenId);

        if (owner == address(0)) {
            // try to check in nft remix !
        }

        return owner;
        
    }


    function buy(
        uint256 tokenId, 
        uint256 price, 
        bool safe, 
        uint256 hookCount
    ) 
        public 
        virtual
        override
        payable 
        nonReentrant 
    {   
        _buy(tokenId);
        super.buy(tokenId, price, safe, hookCount);
    }
    
    function buy(
        uint256 tokenId, 
        address currency, 
        uint256 price, 
        bool safe, 
        uint256 hookCount
    ) 
        public 
        virtual
        override
        nonReentrant 
    {
        _buy(tokenId);
        super.buy(tokenId, currency, price, safe, hookCount);

    }

    //function setSeriesInfo
    //function transfer

    ///////////////////////////////////////////////////////
    //////////////////////////////////////////////////////
    ////////////////////////////////////////////////////
    ///////////////////////////////////////////////////

   

    // /**
    // * @dev sets information for series with 'seriesId'. 
    // * @param seriesId series ID
    // * @param info new info to set
    // * @custom:calledby owner or series author
    // * @custom:shortd set series Info
    // */
    // function setSeriesInfo(
    //     uint64 seriesId, 
    //     SeriesInfo memory info 
    // ) 
    //     external
    // {
    //     _functionDelegateCall(
    //         address(implNFTState), 
    //         // abi.encodeWithSelector(
    //         //     NFTState.setSeriesInfo.selector,
    //         //     seriesId, info
    //         // )
    //         msg.data
    //     );

    // }


    // /**
    // * @dev lists on sale NFT with defined token ID with specified terms of sale
    // * @param tokenId token ID
    // * @param price price for sale 
    // * @param currency currency of sale 
    // * @param duration duration of sale 
    // * @custom:calledby token owner
    // * @custom:shortd list on sale
    // */
    // function listForSale(
    //     uint256 tokenId,
    //     uint256 price,
    //     address currency,
    //     uint64 duration
    // )
    //     external 
    // {
    //     _functionDelegateCall(
    //         address(implNFTState), 
    //         // abi.encodeWithSelector(
    //         //     NFTState.listForSale.selector,
    //         //     tokenId, price, currency, duration
    //         // )
    //         msg.data
    //     );

    // }
    
    // /**
    // * @dev removes from sale NFT with defined token ID
    // * @param tokenId token ID
    // * @custom:calledby token owner
    // * @custom:shortd remove from sale
    // */
    // function removeFromSale(
    //     uint256 tokenId
    // )
    //     external 
    // {
    //     _functionDelegateCall(
    //         address(implNFTState), 
    //         // abi.encodeWithSelector(
    //         //     NFTState.removeFromSale.selector,
    //         //     tokenId
    //         // )
    //         msg.data
    //     );

    // }

    
    // /**
    // * @dev mints and distributes NFTs with specified IDs
    // * to specified addresses
    // * @param tokenIds list of NFT IDs t obe minted
    // * @param addresses list of receiver addresses
    // * @custom:calledby owner or series author
    // * @custom:shortd mint and distribute new tokens
    // */
    // function mintAndDistribute(
    //     uint256[] memory tokenIds, 
    //     address[] memory addresses
    // )
    //     external 
    // {
    //     _functionDelegateCall(
    //         address(implNFTState), 
    //         // abi.encodeWithSelector(
    //         //     NFTState.mintAndDistribute.selector,
    //         //     tokenIds, addresses
    //         // )
    //         msg.data
    //     );

    // }
    
    
    // ///////////////////////////////////////
    // //// external view section ////////////
    // ///////////////////////////////////////


    // /**
    // * @dev returns the list of all NFTs owned by 'account' with limit
    // * @param account address of account
    // * @custom:calledby everyone
    // * @custom:shortd returns the list of all NFTs owned by 'account' with limit
    // */
    // function tokensByOwner(
    //     address account,
    //     uint32 limit
    // ) 
    //     external
    //     view
    //     returns (uint256[] memory ret)
    // {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokensByOwner.selector, 
    //                 account, limit
    //             ), 
    //             ""
    //         ), 
    //         (uint256[])
    //     );

    // }

    
    // /********************************************************************
    // ****** public section ***********************************************
    // *********************************************************************/
    
   


    // ///////////////////////////////////////
    // //// public view section //////////////
    // ///////////////////////////////////////
    // /**
    // * @dev tells the caller whether they can set info for a series,
    // * manage amount of commissions for the series,
    // * mint and distribute tokens from it, etc.
    // * @param seriesId the id of the series being asked about
    // * @custom:calledby everyone
    // * @custom:shortd tells the caller whether they can ьфтпу a series
    // */
    // function canManageSeries(uint64 seriesId) public view returns (bool) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.canManageSeries.selector, 
    //                 seriesId
    //             ), 
    //             ""
    //         ), 
    //         (bool)
    //     );

    // }

    // /**
    // * @dev tells the caller whether they can transfer an existing token,
    // * list it for sale and remove it from sale.
    // * Tokens can be managed by their owner
    // * or approved accounts via {approve} or {setApprovalForAll}.
    // * @param tokenId the id of the tokens being asked about
    // * @custom:calledby everyone
    // * @custom:shortd tells the caller whether they can transfer an existing token
    // */
    // function canManageToken(uint256 tokenId) public view returns (bool) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.canManageToken.selector, 
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (bool)
    //     );
        
    // }

    // /**
    //  * @dev Returns whether `tokenId` exists.
    //  * Tokens start existing when they are minted (`_mint`),
    //  * and stop existing when they are burned (`_burn`).
    //  * @custom:calledby everyone
    //  * @custom:shortd returns whether `tokenId` exists.
    //  */
    // function tokenExists(uint256 tokenId) public view virtual returns (bool) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokenExists.selector, 
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (bool)
    //     );
    // }

    // /**
    // * @dev returns contract URI. 
    // * @custom:calledby everyone
    // * @custom:shortd return contract uri
    // */
    // function contractURI() public view returns(string memory){
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.contractURI.selector
    //             ), 
    //             ""
    //         ), 
    //         (string)
    //     );
    // }

    // /**
    //  * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
    //  * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
    //  * @custom:calledby everyone
    //  * @custom:shortd token of owner by index
    //  */
    // function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokenOfOwnerByIndex.selector, 
    //                 owner, index
    //             ), 
    //             ""
    //         ), 
    //         (uint256)
    //     );
    // }

    // /**
    //  * @dev Returns the total amount of tokens stored by the contract.
    //  * @custom:calledby everyone
    //  * @custom:shortd totalsupply
    //  */
    // function totalSupply() public view virtual override returns (uint256) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.totalSupply.selector
    //             ), 
    //             ""
    //         ), 
    //         (uint256)
    //     );
    // }

    // /**
    //  * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
    //  * Use along with {totalSupply} to enumerate all tokens.
    //  * @custom:calledby everyone
    //  * @custom:shortd token by index
    //  */
    // function tokenByIndex(uint256 index) public view virtual override returns (uint256) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokenByIndex.selector, 
    //                 index
    //             ), 
    //             ""
    //         ), 
    //         (uint256)
    //     );
    // }

    // /**
    //  * @dev See {IERC165-supportsInterface}.
    //  * @custom:calledby everyone
    //  * @custom:shortd see {IERC165-supportsInterface}
    //  */
    // function supportsInterface(bytes4 interfaceId) public view virtual override /*override(ERC165Upgradeable, IERC165Upgradeable)*/ returns (bool) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.supportsInterface.selector, 
    //                 interfaceId
    //             ), 
    //             ""
    //         ), 
    //         (bool)
    //     );
      
    // }

    // /**
    //  * @dev Returns the number of tokens in ``owner``'s account.
    //  * @custom:calledby everyone
    //  * @custom:shortd owner balance
    //  */
    // function balanceOf(address owner) public view virtual override returns (uint256) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.balanceOf.selector, 
    //                 owner
    //             ), 
    //             ""
    //         ), 
    //         (uint256)
    //     );
    // }

    // /**
    //  * @dev Returns the owner of the `tokenId` token.
    //  *
    //  * Requirements:
    //  *
    //  * - `tokenId` must exist.
    //  * @custom:calledby everyone
    //  * @custom:shortd owner address by token id
    //  */

    // function ownerOf(uint256 tokenId) public view virtual override returns (address) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.ownerOf.selector, 
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (address)
    //     );
    // }

    // /**
    //  * @dev Returns the token collection name.
    //  * @custom:calledby everyone
    //  * @custom:shortd token's name
    //  */
    // function name() public view virtual override returns (string memory) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.name.selector
    //             ), 
    //             ""
    //         ), 
    //         (string)
    //     );
    // }

    // /**
    //  * @dev Returns the token collection symbol.
    //  * @custom:calledby everyone
    //  * @custom:shortd token's symbol
    //  */
    // function symbol() public view virtual override returns (string memory) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.symbol.selector
    //             ), 
    //             ""
    //         ), 
    //         (string)
    //     );
    // }

   
    // /**
    //  * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
    //  * @param tokenId token id
    //  * @custom:calledby everyone
    //  * @custom:shortd return token's URI
    //  */
    // function tokenURI(
    //     uint256 tokenId
    // ) 
    //     public 
    //     view 
    //     virtual 
    //     override
    //     returns (string memory) 
    // {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokenURI.selector,
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (string)
    //     );

    // }

    // /**
    //  * @dev Returns the account approved for `tokenId` token.
    //  *
    //  * Requirements:
    //  *
    //  * - `tokenId` must exist.
    //  * @custom:calledby everyone
    //  * @custom:shortd account approved for `tokenId` token
    //  */
    // function getApproved(uint256 tokenId) public view virtual override returns (address) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.getApproved.selector,
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (address)
    //     );
    // }


 

    // /**
    //  * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
    //  *
    //  * See {setApprovalForAll}
    //  * @custom:calledby everyone
    //  * @custom:shortd see {setApprovalForAll}
    //  */
    // function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.isApprovedForAll.selector,
    //                 owner, operator
    //             ), 
    //             ""
    //         ), 
    //         (bool)
    //     );
    // }


    // /**
    // * @dev returns if token is on sale or not, 
    // * whether it exists or not,
    // * as well as data about the sale and its owner
    // * @param tokenId token ID 
    // * @custom:calledby everyone
    // * @custom:shortd return token's sale info
    // */
    // function getTokenSaleInfo(uint256 tokenId) 
    //     public 
    //     view 
    //     returns
    //     (
    //         bool isOnSale,
    //         bool exists, 
    //         SaleInfo memory data,
    //         address owner
    //     ) 
    // {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.getTokenSaleInfo.selector,
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (bool, bool, SaleInfo, address)
    //     );  
    // }

    // /**
    // * @dev returns info for token and series that belong to
    // * @param tokenId token ID 
    // * @custom:calledby everyone
    // * @custom:shortd full info by token id
    // */
    // function tokenInfo(
    //     uint256 tokenId
    // )
    //     public 
    //     view
    //     returns(TokenData memory )
    // {
    //     return abi.decode(
    //         _functionDelegateCallView(
    //             address(implNFTView), 
    //             abi.encodeWithSelector(
    //                 NFTView.tokenInfo.selector,
    //                 tokenId
    //             ), 
    //             ""
    //         ), 
    //         (TokenData)
    //     );  

    // }

    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////

}