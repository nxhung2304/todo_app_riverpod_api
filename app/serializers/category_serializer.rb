# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  archived    :boolean          default(FALSE)
#  color       :string           default("#6366f1")
#  description :text
#  icon        :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class CategorySerializer
  def initialize(category)
    @category = category
  end

  def as_json
    {
      id: @category.id,
      user_id: @category.user_id,
      name: @category.name,
      color: @category.color,
      description: @category.description,
      icon: @category.icon,
      archived: @category.archived,
      created_at: @category.created_at,
      updated_at: @category.updated_at
    }
  end
end
