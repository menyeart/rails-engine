class Api::V1::FindController < ApplicationController
  def show
    merchant = Merchant.find_by_name(params[:name].downcase)
    render json: MerchantSerializer.new(merchant)
  end
end