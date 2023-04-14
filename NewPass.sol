//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface ExistingTokenContracts{
    function balanceOf(address owner) external returns(uint256);
}

contract NewPass is ERC721 {
    
    address public existingTokenContracts; 
    uint16 counter = 0;
    
    mapping(address => bool) public passIssued;
    
    

    constructor(address _existingTokenContract) ERC721("ExampleTokens", "EXt") {
        existingTokenContracts = _existingTokenContract;
    }

    function hasBalance(address _to) public returns(bool){
        uint bal = ExistingTokenContracts(existingTokenContracts).balanceOf(_to);
         if(bal > 0){
             return true;
         }
         else{
             return false;
         }
    }

    function newPass() external returns(bool) {
        require(msg.sender != address(0), "Not a valid address");
        require(passIssued[msg.sender] == false, "pass has been already issed");
        bool holdsNakaTokens = hasBalance(msg.sender);
        require(holdsNakaTokens == true, "You have no nakamigos NFTs");

        uint256 newTokenId = counter++;
        _mint(msg.sender ,newTokenId);
        tokenURI(newTokenId);
        passIssued[msg.sender] = true;

        return true;

    }

}
