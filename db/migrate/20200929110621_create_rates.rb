class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.boolean :forced, default: false
      t.datetime :expiration_at
      t.decimal :value

      t.timestamps
    end
  end
end
