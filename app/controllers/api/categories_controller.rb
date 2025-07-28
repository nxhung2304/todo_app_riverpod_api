module Api
  class CategoriesController < ApplicationApiController
    before_action :set_category, only: %i[update destroy]

    def index
      @categories = @current_api_user.categories
      serialized_categories = @categories.map { |category| CategorySerializer.new(category).as_json }
      render_success_json(
        "Categories retrieved successfully",
        serialized_categories
      )
    end

    def create
      category = @current_api_user.categories.build(category_params)
      category.save!

      serialized_category = CategorySerializer.new(category).as_json
      render_success_json(
        "Category created successfully",
        serialized_category,
        201
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    def update
      @category.update!(category_params)

      serialized_category = CategorySerializer.new(@category).as_json
      render_success_json(
        "Category updated successfully",
        serialized_category
      )
    rescue ActiveRecord::RecordInvalid => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    def destroy
      @category.destroy!

      render_success_json(
        "Category deleted successfully"
      )
    rescue ActiveRecord::RecordNotDestroyed => e
      render_error_json(e.record.errors.full_messages.join(", "), 422)
    end

    private

    def set_category
      @category = @current_api_user.categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error_json("Category not found", 404)
    end

    def category_params
      params.require(:category).permit(
        :archived,
        :color,
        :name,
        :icon
      )
    end
  end
end
