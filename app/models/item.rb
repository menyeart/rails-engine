class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items, :dependent => :destroy
  belongs_to :merchant
  before_destroy :invoices_only_item

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

  def invoices_only_item
    self.invoices.having("count(invoice_items.id) = 1").group("invoices.id")
  end

  private

  # def cleanup
  #   self.invoice_items.destroy_all &&  self.invoices.destroy_all if self.invoices.count == 1
  # end
end