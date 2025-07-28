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
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  context :associations do
    should belong_to(:user)
  end

  context :validations do
    should validate_length_of(:name).is_at_most(255)
    should validate_presence_of(:name)

    should validate_length_of(:color).is_at_most(7)

    should validate_length_of(:icon).is_at_most(255)
  end

  context "color validations" do
    should "accept hex color" do
      category = build(:category, color: "#ffffff")
      assert category.valid?
    end

    should "reject color name" do
      category = build(:category, color: "red")
      assert category.invalid?
    end
  end
end
