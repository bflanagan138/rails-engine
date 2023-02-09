class Merchant < ApplicationRecord
  has_many :items

  # def all_items
  #   self.items
  # end
end
