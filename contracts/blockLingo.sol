// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.22;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
  /**
   * @title ContractName
   * @dev ContractDescription
   * @custom:dev-run-script lingo.sol
   */
  contract ContractName {} 
contract TokenSwap is ReentrancyGuard {
    IERC20 public token1;
    IERC20 public token2;
    uint256 public rate; // How many token2 you get for 1 token1

    event Swap(address indexed user, uint256 token1Amount, uint256 token2Amount);

    constructor(address _token1, address _token2, uint256 _rate) {
        require(_token1 != address(0) && _token2 != address(0), "Invalid token addresses");
        require(_rate > 0, "Invalid rate");
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        rate = _rate;
    }

    function swap(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be greater than 0");
        uint256 token2Amount = amount * rate;

        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer of token1 failed");
        require(token2.transfer(msg.sender, token2Amount), "Transfer of token2 failed");

        emit Swap(msg.sender, amount, token2Amount);
    }

    function updateRate(uint256 newRate) external {
        require(newRate > 0, "Invalid rate");
        rate = newRate;
    }

    function withdrawToken1(uint256 amount) external {
        require(token1.transfer(msg.sender, amount), "Transfer failed");
    }

    function withdrawToken2(uint256 amount) external {
        require(token2.transfer(msg.sender, amount), "Transfer failed");
    }
}