class Music < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user
  has_one_attached :image
  has_one_attached :movie
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :type
  belongs_to_active_hash :month
end
