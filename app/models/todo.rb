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
class Todo < ApplicationRecord
  belongs_to :user

  enum :priority, { low: 1, medium: 3, high: 5 }

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :due_date, comparison: { greater_than: Date.current }, allow_nil: true
  validates :color, hex_color: true, allow_blank: true, length: { maximum: 7 }
end
