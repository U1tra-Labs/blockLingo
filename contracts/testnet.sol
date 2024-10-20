// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.22;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SourceToDestination is ReentrancyGuard {
    IERC20 public token1;
    // IERC20 public token2;
    address public address1 = 0xE70ac9BE5D57181858c8B0F7e840843F0F072305;
    event Send(address indexed user, uint256 token1Amount, uint256 token2Amount);

    constructor(address _token1) {
        require(_token1 != address(0), "Invalid token addresses");
        token1 = IERC20(_token1);
    }

    function transfer(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");

        token1.transferFrom(address(this), address1, amount);
    }

    function swap(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be greater than 0");

        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer of token1 failed");
        // require(token2.transfer(msg.sender, token2Amount), "Transfer of token2 failed");

        // emit Send(msg.sender, amount, token2Amount); 
    }
    

    function withdrawToken1(uint256 amount) external {

        require(token1.transfer(msg.sender, amount), "Transfer failed");
    }

    // function withdrawToken2(uint256 amount) external {
    //     require(token2.transfer(msg.sender, amount), "Transfer failed");
    // }
}
