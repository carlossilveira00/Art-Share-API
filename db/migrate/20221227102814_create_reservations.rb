class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :item, null: false, foreign_key: true
      t.date :starting_date
      t.date :ending_date
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.integer :total_value

      t.timestamps
    end
  end
end
