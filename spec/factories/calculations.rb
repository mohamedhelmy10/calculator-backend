FactoryBot.define do
  factory :calculation do
    operation { '5+5' }
    result { 10.0 }
    count { 1 }
  end
end