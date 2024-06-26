// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Tokenn is ERC20 {
    constructor() ERC20("DEGEN", "DGN") {
        
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
    function redeem_points(address account,uint items) public {
      require(balanceOf(msg.sender)>=(items*5) && msg.sender==account,"Not enough balance");
      _burn(account,(items*5) );

    }
    function decimals() override public pure returns(uint8){
      return 0;
    }

}
