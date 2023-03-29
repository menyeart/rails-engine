class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name,
                        :description,
                        :unit_price, numericality: true
                        :merchant_id

  def self.search_by_name(name)
    Item.where("lower(name) LIKE ?", "%#{name}%").order(name: :asc)
  end

  def self.search_by_prices(min, max)
    Item.where("items.unit_price > ?", min).where("items.unit_price < ?", max)
  end

  def self.search_by_min_price(min)
    Item.where("items.unit_price > ?", min)
  end

  def self.search_by_max_price(max)
    Item.where("items.unit_price < ?", max)
  end



end