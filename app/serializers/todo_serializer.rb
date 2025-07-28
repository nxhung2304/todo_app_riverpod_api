# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  color       :string(7)
#  description :text(500)
#  done        :boolean          default(FALSE)
#  due_date    :date
#  priority    :integer
#  reminder    :boolean
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_todos_on_due_date          (due_date)
#  index_todos_on_user_id           (user_id)
#  index_todos_on_user_id_and_done  (user_id,done)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class TodoSerializer
  def initialize(todo)
    @todo = todo
  end

  def as_json
    {
      id: @todo.id,
      title: @todo.title,
      description: @todo.description,
      done: @todo.done,
      priority: @todo.priority,
      priority_label: @todo.priority&.humanize,
      due_date: @todo.due_date,
      color: @todo.color,
      reminder: @todo.reminder,
      is_overdue: overdue?,
      created_at: @todo.created_at,
      updated_at: @todo.updated_at
    }
  end

  private

  def overdue?
    @todo.due_date.present? && @todo.due_date < Date.current && !@todo.done
  end
end
