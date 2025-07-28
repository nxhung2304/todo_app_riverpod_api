require "test_helper"

class Api::CategoryControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @categories = create_list(:category, 3, user: @user)
    @category = @categories.first

    @auth_headers = @user.create_new_auth_token
  end

  # Index
  test "should get index successfully" do
    get api_categories_url, headers: @auth_headers

    assert_response :success
  end

  # Create
  test "should create a category with valid params" do
    category_attributes = attributes_for(:category)

    assert_difference("Category.count", 1) do
      post api_categories_url, params: { category: category_attributes }, headers: @auth_headers
    end

    assert_response :created
  end

  test "should not create a category with invalid params" do
    category_attributes = attributes_for(:category, name: "")

    assert_difference("Category.count", 0) do
      post api_categories_url, params: { category: category_attributes }, headers: @auth_headers
    end

    assert_response :unprocessable_entity
  end

  # Update
  test "should update a category with valid params" do
    name_updated = "category updated"
    params = {
      category: {
        name: name_updated
      }
    }

    put api_category_url(@category), params: params, headers: @auth_headers

    assert_response :success
    @category.reload
    assert_equal name_updated, @category.name
  end


  test "should not update a category with invalid params" do
    category = @categories.first
    params = {
      category: {
        name: ""
      }
    }
    original_name = category.name

    put api_category_url(category), params: params, headers: @auth_headers
    category.reload

    assert_response :unprocessable_entity
    assert category.name, original_name
  end

  test "update non-existent category returns not found" do
    params = {
      category: { name: "Test" }
    }

    put api_category_url(99999), params: params, headers: @auth_headers
    assert_response :not_found
  end

  # Destroy
  test "should destroy category" do
    category = @categories.first

    assert_difference("Category.count", -1) do
      delete api_category_url(category), headers: @auth_headers
    end

    assert_response :success
  end

  test "destroy non-existent category returns not found" do
    assert_difference("Category.count", 0)    do
      delete api_category_url(99999), headers: @auth_headers
    end

    assert_response :not_found
  end
end
