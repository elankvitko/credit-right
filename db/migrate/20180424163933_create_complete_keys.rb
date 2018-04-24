class CreateCompleteKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :complete_keys do |t|
      t.string  :full_name,   null: false
      t.string  :email,       null: false
      t.string  :key,         null: false, index: true
      t.boolean :used,        null: false, default: false

      t.timestamps
    end
  end
end
