class UpdateUsersApiKey < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :api_key, :string
  end
end
