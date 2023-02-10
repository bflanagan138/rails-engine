class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin
      Item.exists?
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: ItemErrorSerializer.error_json(error, 404), status: 404
    end
  end

  def create
    begin
      new_item = Item.new(item_params)
      new_item.save
      render json: ItemSerializer.new(Item.create!(item_params)), status: 201
    rescue ActionController::ParameterMissing => error
      render json: ItemErrorSerializer.missing_item_error_json(error, 404), status: 404
    end
  end

  def update
    begin
      item = Item.find(params[:id])
      Item.update(item_params)
      item.save
      render json: ItemSerializer.new(item)
    rescue => error
      render json: ItemErrorSerializer.missing_item_error_json(error, 404), status: 404
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