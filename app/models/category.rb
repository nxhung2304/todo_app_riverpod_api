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
class Category < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :color, length: { maximum: 7 }, hex_color: true, allow_blank: true
  validates :icon, length: { maximum: 255 }
  validates :archived, inclusion: { in: [ true, false ] }
end
