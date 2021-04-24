require 'securerandom'

class ChangeApiKeyOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :api_key, :string, :default => SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
