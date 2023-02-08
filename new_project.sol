// Mincoin ICO


contract mincoin_ico {

    // Introducing the maximum number of coins to  be issued
    uint public max_mincoins = 1000000;

    // The USD to Mincoin convertion rate
    uint public usd_to_mincoin_cr = 1000;

    // The number of coins that have been bought
    uint public total_mincoins_bought = 0;

    // Mapping from the investor address to its equity in Mincoins and USD
    mapping(address => uint) equity_mincoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy Mincoins
    modifier can_buy_mincoins(uint usd_invested) {
        // Adding condition
        require (usd_invested * usd_to_mincoin_cr + total_mincoins_bought <= max_mincoins);
        _;
    }

    // Getting the equity in Mincoin of an investor
    function equity_in_mincoins(address investor) external constant returns (uint) {
        return equity_mincoins[investor];
    }

    // Getting equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buying Mincoin   
    function buy_mincoins(address investor, uint usd_invested) external
    can_buy_mincoins(usd_invested) {
        uint mincoins_bought = usd_invested * usd_to_mincoin_cr;
        equity_mincoins[investor] += mincoins_bought;
        equity_usd[investor] = equity_mincoins[investor] / 1000;
        total_mincoins_bought += mincoins_bought;
    }

    // Selling Mincoins
    function sell_mincoins(address investor, uint mincoins_sold) external {
        equity_mincoins[investor] -= mincoins_sold;
        equity_usd[investor] = equity_mincoins[investor] / 1000;
        total_mincoins_bought -= mincoins_sold;
    }
    
}   
