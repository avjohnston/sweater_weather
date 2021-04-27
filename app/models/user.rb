require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: { case_sensitive: true }
  validates :email, uniqueness: true, presence: true

  def update_api_key
    update(api_key: SecureRandom.base64.tr('+/=', 'Qrt'))
  end
end 