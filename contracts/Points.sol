// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Tokenn is ERC20 {
    mapping (uint256 => uint256) public cost;
    mapping(uint256=>string) public items;
    mapping (address=>string[]) public owned_items;
    //event v_items(string memory);
    constructor() ERC20("DEGEN", "DGN") {
        items[1]="T-shirt";
        items[2]="coffee Cup";
        items[3]="Stickers";
        cost[1]=2;
        cost[2]=3;
        cost[3]=4;
    }
    address owner=msg.sender;
    modifier mint_by_owner(){
      require(msg.sender==owner,"Minting allowed to owner only");
      _;
    }
    function mint(address recieve, uint amount)public mint_by_owner{
      _mint(recieve,amount);
    }
    function burn(uint amount)public{
      require(balanceOf(msg.sender)>=amount,"Not enough balance");
      _burn(msg.sender, amount);
    }
    function transfer_points(address rec,uint amount) public{
      require(balanceOf(msg.sender)>=amount,"Not enough balance");
      _transfer(msg.sender, rec, amount);
    }
    function check_balance(address account) external view returns(uint256){
      return this.balanceOf(account);
    }
    function view_items () public pure returns(string memory){

      return("1. T shirt\n2. Coffee mug\n3. stickers");

    }
    function redeem_points(uint choice) public {
      require(balanceOf(msg.sender)>=(cost[choice+1]),"Not enough balance");
      _burn(msg.sender,(cost[choice+1]) );
      owned_items[msg.sender].push(items[choice+1]);

    }
    function view_owned_items() public view returns(string[] memory){
      return owned_items[msg.sender];
     }
    function decimals() override public pure returns(uint8){
      return 0;
    }

}
