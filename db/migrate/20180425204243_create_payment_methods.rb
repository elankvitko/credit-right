class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.string :cnum, null: false, index: true
      t.string :ccvv, null: false
      t.string :cem,  null: false
      t.string :cey,  null: false
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
