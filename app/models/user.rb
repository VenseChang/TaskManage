class User < ApplicationRecord
  has_one :profile
  accepts_nested_attributes_for :profile
  has_and_belongs_to_many :tasks
end
