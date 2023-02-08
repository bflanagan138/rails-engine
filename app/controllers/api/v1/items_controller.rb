class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    # else
    #   render json: { errors: "Error: Item does not exist" }, status: 404
    # end
  end

  def create
    new_item = Item.new(item_params)
    if new_item.save
      render json: ItemSerializer.new(Item.create!(item_params)), status: 201
    else
      render json: { error: "Invalid item" }, status: 404
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end