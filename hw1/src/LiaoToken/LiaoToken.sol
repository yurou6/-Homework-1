// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract LiaoToken is IERC20 {
    // TODO: you might need to declare several state variable here

    mapping(address account => uint256) private _balances;
    mapping(address account => bool) isClaim;
    mapping(address account => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    event Claim(address indexed user, uint256 indexed amount);

    constructor(string memory name_, string memory symbol_) payable {
        _name = name_;
        _symbol = symbol_;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function claim() external returns (bool) {
        if (isClaim[msg.sender]) revert();
        _balances[msg.sender] += 1 ether;
        _totalSupply += 1 ether;
        emit Claim(msg.sender, 1 ether);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        // TODO: please add your implementaiton here
        // 誰去呼叫 就把他的錢傳給對方
        if (amount > _balances[msg.sender]) {
            revert();
        }

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit Transfer(msg.sender, to ,amount);

        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        // TODO: please add your implementaiton here
        // from:Alice to:Bob
        // 我是Louis 我去呼叫Alice transfer money to Bob 
        // 可能成功 因為Alice給Louis權限 //權限記錄在allowance()，所以call allowance()檢查權限
        if(_balances[from] < value){
            revert();
        }
        if(_allowances[from][msg.sender] < value){
            revert();
        }

        _balances[from] -= value;
        _allowances[from][msg.sender] -= value;
        _balances[to] += value;

        emit Transfer(from, to ,value);

        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        // TODO: please add your implementaiton here
        // 拿憑證操作你的錢
        // 誰有誰的憑證、憑證裡有多少錢 mapping應該比較適合
        _allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        // TODO: please add your implementaiton here
        return _allowances[owner][spender];
    }
}
