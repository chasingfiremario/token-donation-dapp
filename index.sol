// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Donation {
    struct Cause {
        string name;
        address payable recipient;
        uint256 totalDonations;
    }

    Cause[] public causes;

    function addCause(string memory _name, address payable _recipient) public {
        causes.push(Cause(_name, _recipient, 0));
    }

    function donate(uint256 _causeId, uint256 _amount, address _tokenAddress) public {
        IERC20 token = IERC20(_tokenAddress);
        token.transferFrom(msg.sender, causes[_causeId].recipient, _amount);
        causes[_causeId].totalDonations += _amount;
    }

    function getCauses() public view returns (Cause[] memory) {
        return causes;
    }
}
