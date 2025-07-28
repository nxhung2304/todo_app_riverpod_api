class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true

      t.string :name, null: false
      t.string :color, default: '#6366f1'
      t.string :icon
      t.text :description
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
