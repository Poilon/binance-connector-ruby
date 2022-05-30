# frozen_string_literal: true

module Binance
  class Spot
    # Futures endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#futures
    module Futures
      # Get Future Symbol Price Ticker
      #
      # GET /fapi/v1/ticker/price
      #
      # @option kwargs [String] :symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/futures/en/#symbol-price-ticker
      def future_symbol_price_ticker(**kwargs)
        @session.base_url = "https://fapi.binance.com"
        result = @session.sign_request(:get, "/fapi/v1/ticker/price", params: kwargs)
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Future User Trades (USER_DATA)
      #
      # GET /fapi/v1/userTrades
      #
      # @param symbol [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/futures/en/#account-trade-list-user_data
      def future_trades(symbol:, **kwargs)
        Binance::Utils::Validation.require_param("symbol", symbol)

        @session.base_url = "https://fapi.binance.com"
        result = @session.sign_request(:get, "/fapi/v1/userTrades", params: kwargs.merge(symbol: symbol))
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Future Symbol Price Ticker
      #
      # GET /dapi/v1/ticker/price
      #
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/delivery/en/#symbol-price-ticker
      def delivery_symbol_price_ticker(**kwargs)
        @session.base_url = "https://dapi.binance.com"
        result = @session.sign_request(:get, "/dapi/v1/ticker/price", params: kwargs)
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Income History(USER_DATA)
      #
      # GET /dapi/v1/income
      #

      # @option symbol [String]
      # @option incomeType [String] "TRANSFER","WELCOME_BONUS", "FUNDING_FEE", "REALIZED_PNL", "COMMISSION", "INSURANCE_CLEAR", and "DELIVERED_SETTELMENT"
      # @option startTime [Integer] Timestamp in ms to get funding from INCLUSIVE.
      # @option endTime [Integer] Timestamp in ms to get funding until INCLUSIVE.
      # @option limit [Integer] Default 100; max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/delivery/en/#get-income-history-user_data
      def delivery_incomes(**kwargs)
        @session.base_url = "https://dapi.binance.com"
        result = @session.sign_request(:get, "/dapi/v1/income", params: kwargs)
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Funding Rate History
      #
      # GET /fapi/v1/fundingRate
      #
      # @option symbol [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/futures/en/#get-funding-rate-history
      def future_funding_rates(**kwargs)
        @session.base_url = "https://fapi.binance.com"
        result = @session.sign_request(:get, "/fapi/v1/fundingRate", params: kwargs)
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Download Id For Futures Transaction History (USER_DATA)
      #
      # GET /fapi/v1/income/asyn
      #
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/futures/en/#get-download-id-for-futures-transaction-history-user_data
      def incomes_asyn(start_time:, end_time:, **kwargs)
        Binance::Utils::Validation.require_param("start_time", start_time)
        Binance::Utils::Validation.require_param("end_time", end_time)

        @session.base_url = "https://fapi.binance.com"
        result = @session.sign_request(:get, "/fapi/v1/income/asyn", params: kwargs.merge(startTime: start_time, endTime: end_time))
        @session.base_url = "https://api.binance.com"
        result
      end

      # Get Futures Transaction History Download Link by Id (USER_DATA)
      #
      # GET /fapi/v1/income/asyn/id
      #
      # @param downloadId [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/futures/en/#get-futures-transaction-history-download-link-by-id-user_data
      def incomes_asyn_by_id(download_id:, **kwargs)
        Binance::Utils::Validation.require_param("download_id", download_id)

        @session.base_url = "https://fapi.binance.com"
        result = @session.sign_request(:get, "/fapi/v1/income/asyn/id", params: kwargs.merge(downloadId: download_id))
        @session.base_url = "https://api.binance.com"
        result
      end

      # New Future Account Transfer (USER_DATA)
      #
      # POST /sapi/v1/futures/transfer
      #
      # Execute transfer between spot account and futures account.
      #
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from spot account to USDT-M futures account. <br>
      #   2: transfer from USDT-M futures account to spot account. <br>
      #   3: transfer from spot account to COIN-M futures account. <br>
      #   4: transfer from COIN-M futures account to spot account. <br>
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#new-future-account-transfer-user_data
      def futures_account_transfer(asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param("asset", asset)
        Binance::Utils::Validation.require_param("amount", amount)
        Binance::Utils::Validation.require_param("type", type)

        @session.sign_request(:post, "/sapi/v1/futures/transfer", params: kwargs.merge(
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Get Future Account Transaction History List (USER_DATA)
      #
      # GET /sapi/v1/futures/transfer
      #
      # @param asset [String]
      # @param startTime [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-future-account-transaction-history-list-user_data
      def futures_account_transfer_history(asset:, startTime:, **kwargs)
        Binance::Utils::Validation.require_param("asset", asset)
        Binance::Utils::Validation.require_param("startTime", startTime)

        @session.sign_request(:get, "/sapi/v1/futures/transfer", params: kwargs.merge(
          asset: asset,
          startTime: startTime
        ))
      end

      # Borrow For Cross-Collateral (TRADE)
      #
      # POST /sapi/v1/futures/loan/borrow
      #
      # @param coin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Float] :amount Mandatory when collateralAmount is empty.
      # @option kwargs [Float] :collateralAmount Mandatory when amount is empty.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#borrow-for-cross-collateral-trade
      def cross_collateral_borrow(coin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param("coin", coin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)

        @session.sign_request(:post, "/sapi/v1/futures/loan/borrow", params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin
        ))
      end

      # Cross-Collateral Borrow History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/borrow/history
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-borrow-history-user_data
      def cross_collateral_borrow_history(**kwargs)
        @session.sign_request(:get, "/sapi/v1/futures/loan/borrow/history", params: kwargs)
      end

      # Repay For Cross-Collateral (TRADE)
      #
      # POST /sapi/v1/futures/loan/repay
      #
      # @param coin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#repay-for-cross-collateral-trade
      def cross_collateral_repay(coin:, collateralCoin:, amount:, **kwargs)
        Binance::Utils::Validation.require_param("coin", coin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)
        Binance::Utils::Validation.require_param("amount", amount)

        @session.sign_request(:post, "/sapi/v1/futures/loan/repay", params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin,
          amount: amount
        ))
      end

      # Cross-Collateral Repayment History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/repay/history
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-repayment-history-user_data
      def cross_collateral_repay_history(**kwargs)
        @session.sign_request(:get, "/sapi/v1/futures/loan/repay/history", params: kwargs)
      end

      # Cross-Collateral Wallet (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/wallet
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-wallet-v2-user_data
      def cross_collateral_wallet(**kwargs)
        @session.sign_request(:get, "/sapi/v2/futures/loan/wallet", params: kwargs)
      end

      # Cross-Collateral Information (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/configs
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-information-v2-user_data
      def cross_collateral_info(**kwargs)
        @session.sign_request(:get, "/sapi/v2/futures/loan/configs", params: kwargs)
      end

      # Calculate Rate After Adjust Cross-Collateral LTV (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/calcAdjustLevel
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param direction [String] "ADDITIONAL", "REDUCED"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#calculate-rate-after-adjust-cross-collateral-ltv-v2-user_data
      def calculate_adjust_rate(loanCoin:, collateralCoin:, amount:, direction:, **kwargs)
        Binance::Utils::Validation.require_param("loanCoin", loanCoin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)
        Binance::Utils::Validation.require_param("amount", amount)
        Binance::Utils::Validation.require_param("direction", direction)

        @session.sign_request(:get, "/sapi/v2/futures/loan/calcAdjustLevel", params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          amount: amount,
          direction: direction
        ))
      end

      # Get Max Amount for Adjust Cross-Collateral LTV (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/calcMaxAdjustAmount
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-max-amount-for-adjust-cross-collateral-ltv-v2-user_data
      def calculate_adjust_max_amount(loanCoin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param("loanCoin", loanCoin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)

        @session.sign_request(:get, "/sapi/v2/futures/loan/calcMaxAdjustAmount", params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin
        ))
      end

      # Adjust Cross-Collateral LTV (TRADE)
      #
      # POST /sapi/v2/futures/loan/adjustCollateral
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param direction [String] "ADDITIONAL", "REDUCED"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#adjust-cross-collateral-ltv-v2-trade
      def adjust_cross_collateral(loanCoin:, collateralCoin:, amount:, direction:, **kwargs)
        Binance::Utils::Validation.require_param("loanCoin", loanCoin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)
        Binance::Utils::Validation.require_param("amount", amount)
        Binance::Utils::Validation.require_param("direction", direction)

        @session.sign_request(:post, "/sapi/v2/futures/loan/adjustCollateral", params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          amount: amount,
          direction: direction
        ))
      end

      # Adjust Cross-Collateral LTV History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/adjustCollateral/history
      #
      # All data will be returned if loanCoin or collateralCoin is not sent
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#adjust-cross-collateral-ltv-history-user_data
      def adjust_cross_collateral_history(**kwargs)
        @session.sign_request(:get, "/sapi/v1/futures/loan/adjustCollateral/history", params: kwargs)
      end

      # Cross-Collateral Liquidation History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/liquidationHistory
      #
      # All data will be returned if loanCoin or collateralCoin is not sent
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-liquidation-history-user_data
      def cross_collateral_liquidation_history(**kwargs)
        @session.sign_request(:get, "/sapi/v1/futures/loan/liquidationHistory", params: kwargs)
      end

      # Check Collateral Repay Limit (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepayLimit
      #
      # Check the maximum and minimum limit when repay with collateral.
      #
      # @param coin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#check-collateral-repay-limit-user_data
      def collateral_repay_limit(coin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param("coin", coin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)

        @session.sign_request(:get, "/sapi/v1/futures/loan/collateralRepayLimit", params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin
        ))
      end

      # Get Collateral Repay Quote (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepay
      #
      # Get quote before repay with collateral is mandatory, the quote will be valid within 25 seconds.
      #
      # @param coin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-collateral-repay-quote-user_data
      def collateral_repay_quote(coin:, collateralCoin:, amount:, **kwargs)
        Binance::Utils::Validation.require_param("coin", coin)
        Binance::Utils::Validation.require_param("collateralCoin", collateralCoin)
        Binance::Utils::Validation.require_param("amount", amount)

        @session.sign_request(:get, "/sapi/v1/futures/loan/collateralRepay", params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin,
          amount: amount
        ))
      end

      # Repay with Collateral (USER_DATA)
      #
      # POST /sapi/v1/futures/loan/collateralRepay
      #
      # Repay with collateral. Get quote before repay with collateral is mandatory, the quote will be valid within 25 seconds.
      #
      # @param quoteId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#repay-with-collateral-user_data
      def repay_with_collateral(quoteId:, **kwargs)
        Binance::Utils::Validation.require_param("quoteId", quoteId)

        @session.sign_request(:post, "/sapi/v1/futures/loan/collateralRepay", params: kwargs.merge(
          quoteId: quoteId
        ))
      end

      # Collateral Repayment Result (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepayResult
      #
      # Check collateral repayment result.
      #
      # @param quoteId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#collateral-repayment-result-user_data
      def repayment_result(quoteId:, **kwargs)
        Binance::Utils::Validation.require_param("quoteId", quoteId)

        @session.sign_request(:get, "/sapi/v1/futures/loan/collateralRepayResult", params: kwargs.merge(
          quoteId: quoteId
        ))
      end

      # Cross-Collateral Interest History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/interestHistory
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-interest-history-user_data
      def cross_collateral_interest_history(**kwargs)
        @session.sign_request(:get, "/sapi/v1/futures/loan/interestHistory", params: kwargs)
      end
    end
  end
end
