class CategorySerializer
  def initialize(category)
    @category = category
  end

  def as_json
    {
      id: @category.id,
      name: @category.name,
      color: @category.color,
      description: @category.description,
      icon: @category.icon,
      created_at: @category.created_at,
      updated_at: @category.updated_at
    }
  end
end
