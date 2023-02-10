class Api::V1::Merchants::SearchController < ApplicationController
  def index 
    search_merchants = []
    Merchant.all.each do |m|
      if m[:name].downcase.include?(params["name"].downcase)
        search_merchants << m
      end
    end
    search_merchants
    if search_merchants.empty? == false
      render json: MerchantSerializer.new(search_merchants)
    else 
      render json: MerchantErrorSerializer.search_error(404), status: 404
    end
  end
end