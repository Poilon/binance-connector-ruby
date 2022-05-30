# frozen_string_literal: true

module Binance
  class Spot
    module UniversalTransfer

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
    end
  end
end
