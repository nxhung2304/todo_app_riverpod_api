module Api
  class TodosController < ApplicationApiController
    before_action :set_todo, only: %i[update destroy toggle]

    def index
      @todos = @current_api_user.todos
      serialized_todos = @todos.map { |todo| TodoSerializer.new(todo).as_json }

      render_success_json(
        "Todos retrieved successfully",
        serialized_todos
      )
    end

    def create
      todo = @current_api_user.todos.create!(todo_params)

      serialized_todo = TodoSerializer.new(todo).as_json
      render_success_json(
        "Todo updated successfully",
        serialized_todo,
        201
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    def update
      @todo.update!(todo_params)

      serialized_todo = TodoSerializer.new(@todo).as_json
      render_success_json(
        "Todo updated successfully",
        serialized_todo
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    def destroy
      @todo.destroy!

      serialized_todo = TodoSerializer.new(@todo).as_json
      render_success_json(
        "Todo deleted successfully",
        serialized_todo
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    def toggle
      @todo.update!(done: !@todo.done)

      serialized_todo = TodoSerializer.new(@todo).as_json
      render_success_json(
        "Todo toggled successfully",
        serialized_todo
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    private

      def set_todo
        @todo = @current_api_user.todos.find(params[:id])
      end

      def todo_params
        params.require(:todo).permit(
          :title,
          :description,
          :done,
          :due_date,
          :priority,
          :reminder,
          :user_id
        )
      end
  end
end
