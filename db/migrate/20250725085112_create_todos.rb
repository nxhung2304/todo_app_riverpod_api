class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title, null: false, limit: 255
      t.text :description, null: true, limit: 500
      t.date :due_date, null: true
      t.integer :priority
      t.string :color, limit: 7
      t.boolean :reminder
      t.boolean :done, default: false

      t.timestamps
    end

    add_index :todos, [ :user_id, :done ]
    add_index :todos, :due_date
  end
end
