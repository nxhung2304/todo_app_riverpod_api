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
FactoryBot.define do
  factory :todo do
    association :user
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    due_date { 1.week.from_now }
    priority { %w[low medium high].sample }
    color { Faker::Color.hex_color }

    trait :completed do
      done { true }
    end

    trait :overdue do
      due_date { 1.day.ago }
      done { false }
    end

    trait :low_priority do
      priority { "low" }
    end

    trait :medium_priority do
      priority { "medium" }
    end

    trait :high_priority do
      priority { "high" }
    end
  end
end
