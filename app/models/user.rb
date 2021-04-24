require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: { case_sensitive: true }
  validates :email, uniqueness: true, presence: true
  after_initialize :default_api
  
  def default_api
    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
  end 
end 