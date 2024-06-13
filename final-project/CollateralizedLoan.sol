// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CollateralizedLoan {
    ERC20 public collateralToken;

    uint256 public interestRate;

    uint256 public minCollateralizedRatio;

    enum LoanStatus {Created, Funded, Taken, Repayed, Liquidated}

    struct LoanInfo {    
        address borrower;
        address lender;
        uint256 borrowAmount;
        uint256 timelines;
        LoanStatus status;
    }

    constructor(uint256 _interestRate){
interestRate = _interestRate;
    }

    function requestLoan(uint _interestRate){

    }
}
