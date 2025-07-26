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
require "test_helper"

class TodoTest < ActiveSupport::TestCase
  context :associations do
    should belong_to(:user)
  end

  context :validations do
    should validate_presence_of(:title)
    should validate_length_of(:title).is_at_most(255)
    should validate_length_of(:description).is_at_most(500)

    should define_enum_for(:priority)
    .with_values(low: 1, medium: 3, high: 5)
  end

  context "due_date validation" do
    should "accept future date" do
      todo = build(:todo, due_date: 1.day.from_now)
      assert todo.valid?
    end

    should "reject past date" do
      todo = build(:todo, due_date: 1.day.ago)
      assert todo.invalid?
    end
  end

  context "color validations" do
    should "accept hex color" do
      todo = build(:todo, color: "#ffffff")
      assert todo.valid?
    end

    should "reject color name" do
      todo = build(:todo, color: "red")
      assert todo.invalid?
    end
  end
end
