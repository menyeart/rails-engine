class Api::V1::FindAllController < ApplicationController
  
  def index
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
end