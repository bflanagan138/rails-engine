class Api::V1::MerchantItemsController < ApplicationController
  def index
    begin
      Merchant.exists?(params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
        render json: ItemSerializer.new(merchant.items)
    rescue ActiveRecord::RecordNotFound => error
      # require 'pry'; binding.pry
      render json: MerchantItemErrorSerializer.error_json(error), status: 404
    end
  end
end