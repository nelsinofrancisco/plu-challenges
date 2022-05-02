class Property < ApplicationRecord
  has_one_attached :image
  has_many_attached :pictures
end
