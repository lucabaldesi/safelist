class CreateIngriedents < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.boolean :confirmed
      t.boolean :safe

      t.timestamps null: false
    end
  end
end
