class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :user do |t|
      t.string :phone_number
      t.string :zip_code
    end
  end

  def self.down
    drop_table :user
  end
end
