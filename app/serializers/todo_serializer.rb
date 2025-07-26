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
