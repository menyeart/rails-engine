class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :invoice_items, :dependent => :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
end