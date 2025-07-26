require "test_helper"

class Api::TodoControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @todos = create_list(:todo, 3, user: @user)
    @todo = @todos.first

    @auth_headers = @user.create_new_auth_token
  end

  # Index
  test "should get index successfully" do
    get api_todos_url, headers: @auth_headers

    assert_response :success
  end

  # Create
  test "should create a todo with valid params" do
    todo_attributes = attributes_for(:todo)

    assert_difference("Todo.count", 1) do
      post api_todos_url, params: { todo: todo_attributes }, headers: @auth_headers
    end

    assert_response :created
  end

  test "should not create a todo with invalid params" do
    todo_attributes = attributes_for(:todo, title: "")

    assert_difference("Todo.count", 0) do
      post api_todos_url, params: { todo: todo_attributes }, headers: @auth_headers
    end

    assert_response :unprocessable_entity
  end

  # Update
  test "should update a todo with valid params" do
    title_updated = "todo updated"
    params = {
      todo: {
        title: title_updated
      }
    }

    put api_todo_url(@todo), params: params, headers: @auth_headers

    assert_response :success
    @todo.reload
    assert_equal title_updated, @todo.title
  end


  test "should not update a todo with invalid params" do
    todo = @todos.first
    params = {
      todo: {
        title: ""
      }
    }
    original_title = todo.title

    put api_todo_url(todo), params: params, headers: @auth_headers
    todo.reload

    assert_response :unprocessable_entity
    assert todo.title, original_title
  end

  test "update non-existent todo returns not found" do
    params = {
      todo: { title: "Test" }
    }

    put api_todo_url(99999), params: params, headers: @auth_headers
    assert_response :not_found
  end

  # Destroy
  test "should destroy todo" do
    todo = @todos.first

    assert_difference("Todo.count", -1) do
      delete api_todo_url(todo), headers: @auth_headers
    end

    assert_response :no_content
  end

  test "destroy non-existent todo returns not found" do
    assert_difference("Todo.count", 0)    do
      delete api_todo_url(99999), headers: @auth_headers
    end

    assert_response :not_found
  end
end
