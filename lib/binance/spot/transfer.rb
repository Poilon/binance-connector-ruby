# frozen_string_literal: true

module Binance
  class Spot
    module Transfer

      # Query Universal Transfer History
      #
      # GET /sapi/v1/sub-account/universalTransfer
      #
      # @option kwargs [String]  :fromEmail
      # @option kwargs [String]  :toEmail
      # @option kwargs [String]  :clientTranId
      # @option kwargs [Integer]  :startTime
      # @option kwargs [Integer]  :endTime
      # @option kwargs [Integer]  :page
      # @option kwargs [Integer]  :limit
      # @option kwargs [Integer]  :recvWindow
      # @see https://binance-docs.github.io/apidocs/spot/en/#universal-transfer-for-master-account
      def universal_transfer(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/universalTransfer', params: kwargs)
      end

      # Query Sub-account Transfer History
      #
      # GET /sapi/v1/sub-account/transfer/subUserHistory
      #
      # @option kwargs [String]  :asset
      # @option kwargs [String]  :clientTranId
      # @option kwargs [Integer]  :type (1: transfer in, 2: transfer out)
      # @option kwargs [Integer]  :startTime
      # @option kwargs [Integer]  :endTime
      # @option kwargs [Integer]  :limit
      # @option kwargs [Integer]  :recvWindow
      # @see https://binance-docs.github.io/apidocs/spot/en/#sub-account-transfer-history-for-sub-account
      def sub_account_transfer(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/transfer/subUserHistory', params: kwargs)
      end
    end
  end
end
