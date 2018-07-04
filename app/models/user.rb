class User < ApplicationRecord
  has_one :profile
  accepts_nested_attributes_for :profile
  has_and_belongs_to_many :tasks

  def encodePassword(password)
    salt = Time.now.to_i - Random.rand(1000000000)
    pwd  = Digest::SHA512.hexdigest("password:#{password}&salt:#{salt}")
    self.password = "$#{salt}$#{pwd}"
  end
end
