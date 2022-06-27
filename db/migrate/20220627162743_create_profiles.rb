# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
