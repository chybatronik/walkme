# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "MyString"
    text "MyText"
    url "MyText"
    object "MyText"
  end
end
