class Api::V1::FindController < ApplicationController
  def show
    begin
      merchant = Merchant.find_by_name(params[:name].downcase)
      render json: MerchantSerializer.new(merchant)
    rescue => exception
      render json: ErrorSerializer.error_to_empty, status: 200
    end  
  end
end