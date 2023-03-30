class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def self.find_by_name(name)
    Merchant.where("lower(name) LIKE ?", "%#{name}%").order(name: :asc).first!
  end
end
