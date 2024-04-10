class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.boolean :active
      t.integer :user_id

      t.timestamps
    end
  end
end
