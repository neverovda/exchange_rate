class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.boolean :forced, default: false
      t.datetime :to
      t.decimal :price
      # t.decimal5 :price
      # t.decimal2 :price

      t.timestamps
    end
  end
end
