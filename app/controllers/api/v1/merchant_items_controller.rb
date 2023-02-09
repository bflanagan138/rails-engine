class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      # require 'pry'; binding.pry
      render json: ItemSerializer.new(merchant.items)
    else
      render json: { errors: "Error: merchant does not exist" }, status: 404
    end
  end
end