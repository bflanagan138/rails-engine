class Api::V1::ItemMerchantController < ApplicationController
  def index
    begin
      item = Item.find(params[:item_id])
        render json: MerchantSerializer.new(item.merchant)
    rescue ActiveRecord::RecordNotFound => error
      render json: MerchantItemErrorSerializer.error_json(error), status: 404
    end
  end
end