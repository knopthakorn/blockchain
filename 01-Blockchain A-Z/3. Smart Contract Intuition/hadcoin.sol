// Hadcoin ICO

// Version of complier
pragma solidity >=0.4.11;

contract hadcoin_ico {

    // Introducing the maximum number of Hadcoins available for sale
    uint max_hadcoins = 1000000;

    // Introducing the USD to Uadcoins conversion rate
    uint usd_to_hadcoins = 1000;

    // Introducing the total number of Hadcoins that have been bough by the investors
    uint total_hadcoins_bought = 0;

    // Mapping from investor address ti its equity in Hadcoins an usd_to_hacoins
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy Hadcoins
    modifier can_buy_hadcoins(uint usd_investor) {
        require(usd_investor * usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
        _;
    }

    // Getting the equity in Hadcoins of an investor
    function equity_in_hadcoins(address investor) external view returns (uint) {
        return equity_hadcoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Buying Hadcoins
    function buy_hadcoins(address investor, uint usd_invested) external
    can_buy_hadcoins(usd_invested) {
        uint hadcoins_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor]/usd_to_hadcoins;
        total_hadcoins_bought += hadcoins_bought;
    }

    // Buying Hadcoins
    function sell_hadcoins(address investor, uint hadcoins_sold) external {
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor]/usd_to_hadcoins;
        total_hadcoins_bought -= hadcoins_sold;
    }
}
