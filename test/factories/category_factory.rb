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
FactoryBot.define do
  factory :category do
    association :user
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    icon { Faker::Lorem.paragraph }
    color { Faker::Color.hex_color }
    archived { Faker::Boolean.boolean }
  end
end
