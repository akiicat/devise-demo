class Book < ApplicationRecord
  # cocoon
  has_many :directions, inverse_of: :book
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  # paperclip
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
