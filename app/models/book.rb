class Book < ApplicationRecord
  has_many :directions, inverse_of: :book

  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true
end
