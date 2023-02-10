class Api::V1::MerchantItemsController < ApplicationController
  def index
    begin
      merchant = Merchant.find(params[:merchant_id])
        render json: ItemSerializer.new(merchant.items)
    rescue ActiveRecord::RecordNotFound => error
      render json: MerchantItemErrorSerializer.error_json(error), status: 404
    end
  end
end