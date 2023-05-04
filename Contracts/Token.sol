// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "Contracts/IERC20.sol";
import "Contracts/Ownable.sol";

contract Token is IERC20 ,Ownable{
    string private constant _name = "Lean";
    string private constant _symbol = "LEN";
    uint8 private constant _decimals = 18;
    uint256 private _totalSupply;


    mapping (address=>uint256) balance;
    mapping (address=>mapping (address => uint256)) allowed;

    constructor (uint256 totalSupply_){
       _totalSupply = totalSupply_ * (10 ** _decimals);
       balance[msg.sender] = _totalSupply;
       emit Transfer(address(0),msg.sender, _totalSupply);
    }

    function name() pure public returns (string memory) {
        return _name;
    }           
    function symbol() pure public returns (string memory) {
        return _symbol;
    }     
    function decimals() pure public returns (uint8) {
        return _decimals;
    }

    function totalSupply()public view  returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account)public view  returns (uint256){
        return balance[account];
    }
    function allowance(address owner , address spender)public  view returns (uint256){
      return allowed[owner][spender];
    }

    function transfer(address to, uint256 value)public returns (bool){
        balance[msg.sender] -= value;
        balance[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function transferFrom(address from, address to , uint256 value)public returns (bool){
        allowed[from][msg.sender] -= value;
        balance[from] -= value;
        balance[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
    function approve(address spender, uint256 value)public returns (bool){
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function mint(address to, uint256 value) external {
        _totalSupply += value;
        balance[to] += value;
        emit Transfer(address(0), to, value);
    }

    function burn(address from, uint256 value) external {
        balance[from] -= value;
        _totalSupply -= value;
        emit Transfer(from,address(0), value);
    }
}