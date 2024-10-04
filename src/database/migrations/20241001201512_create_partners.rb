# frozen_string_literal: true

class CreatePartners < ActiveRecord::Migration[7.1]
  def change
    create_table :partners, id: false do |t|
      t.string :id, primary_key: true, limit: 36, null: false
      t.string :name, limit: 255

      t.timestamps
    end
  end
end
