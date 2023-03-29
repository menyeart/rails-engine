class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render_not_created_response
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item), status: 201
    else
      render_not_updated_response
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def find_all
    if (params.has_key?(:max_price) && params[:max_price].to_f < 0)  || (params.has_key?(:min_price) && params[:min_price].to_f < 0) 
      bad_params_response
    elsif params.keys.length > 4 || params.keys.length < 3
      bad_params_response
    elsif params.keys.include?("min_price") && params.keys.include?("name") || params.keys.include?("max_price") && params.keys.include?("name")
      bad_params_response
    elsif params.keys.include?("min_price") && params.keys.include?("max_price")
      items = Item.search_by_prices(params[:max_price], params[:min_price])
      render json: ItemSerializer.new(items)
    elsif params.keys.include?("min_price") 
      items =Item.search_by_min_price(params[:min_price])
      render json: ItemSerializer.new(items)
    elsif params.keys.include?("max_price")
      items =Item.search_by_max_price(params[:max_price])
      render json: ItemSerializer.new(items)
    else
      items =Item.search_by_name(params[:name].downcase)
      render json: ItemSerializer.new(items)
    end 

  end
   
  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id )
  end

end