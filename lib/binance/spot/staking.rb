module Binance
  class Spot
    # all stakings endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#staking-endpoints
    module Staking
      # Get Staking Product Position (USER_DATA)
      #
      # GET /sapi/v1/staking/position (HMAC SHA256)
      #

      # @param product [String] enum: "STAKING", "F_DEFI", "L_DEFI"
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :current Current query page. Default: 1, Min: 1
      # @option kwargs [Integer] :size Default: 50, Max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-product-list-user_data
      def staking_product_position(product:, **kwargs)
        @session.sign_request(:get, "/sapi/v1/staking/position", params: kwargs.merge(product: product))
      end
    end
  end
end
