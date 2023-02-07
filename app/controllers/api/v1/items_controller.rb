class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  # def show
  #   # if Merchant.exists?(params[:id])
  #     render json: MerchantSerializer.new(Merchant.find(params[:id]))
  #   # else
  #   #   render json: { errors: "Error: merchant does not exist" }, status: 404
  #   # end
  # end
end