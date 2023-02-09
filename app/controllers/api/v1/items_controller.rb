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

  def update
    item = Item.find(params[:id])
    Item.update(item_params)
    if item.save
      render json: ItemSerializer.new(item)
    else
      render json: { errors: "Item not updated" }, status: 404
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end