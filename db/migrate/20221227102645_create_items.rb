class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.string :location
      t.string :current_situation

      t.timestamps
    end
  end
end
