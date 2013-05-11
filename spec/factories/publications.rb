# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :publication do
    url "MyText"
    user_id 1
    catalog_id 1
  end
end
