// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Tokenn is ERC20 {
    mapping (uint256 => uint256) public items;
    constructor() ERC20("DEGEN", "DGN") {
        items[1]=2;
        items[2]=4;
        items[3]=1;
    }
    address owner=msg.sender;
    modifier mint_by_owner(){
      require(msg.sender==owner,"Minting allowed to owner only");
      _;
    }
    function mint(address recieve, uint amount)public mint_by_owner{
      _mint(recieve,amount);
    }
    function burn(address account,uint amount)public{
      require(balanceOf(msg.sender)>=amount && msg.sender==account,"Not enough balance");
      _burn(account, amount);
    }
    function transfer(address send,address rec,uint amount) public{
      require(balanceOf(msg.sender)>=amount && msg.sender==send ,"Not enough balance");
      _transfer(send, rec, amount);
    }
    function check_balance(address account) external view returns(uint256){
      return this.balanceOf(account);
    }
    function view_items () public pure returns(string memory){
      
      return("1. T shirt\n2. Coffee mug\n3. stickers");

    }
    function redeem_points(address account,uint choice) public {
      require(balanceOf(msg.sender)>=(items[choice]) && msg.sender==account,"Not enough balance");
      _transfer(account,owner,(items[choice]) );

    }
    function decimals() override public pure returns(uint8){
      return 0;
    }

}
