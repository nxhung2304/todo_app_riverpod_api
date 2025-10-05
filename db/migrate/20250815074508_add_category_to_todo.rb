class AddCategoryToTodo < ActiveRecord::Migration[8.0]
  def change
    add_reference :todos, :category, null: false, foreign_key: true
  end
end
