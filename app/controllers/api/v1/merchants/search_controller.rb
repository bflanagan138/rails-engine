class Api::V1::Merchants::SearchController < ApplicationController
  def index
    search_merchants = []
    Merchant.all.each do |m|
      if m[:name].include?(params["name"])
        search_merchants << m
      end
    end
    search_merchants
    render json: MerchantSerializer.new(search_merchants)
  end
end