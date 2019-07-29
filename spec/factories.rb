FactoryBot.define do
  sequence :name do |n|
    "Test Athlete #{n}"
  end
  factory :athlete do
    name { generate :name }
    sex { "M" }
    age { 21 }
    height { 160 }
    weight { 70 }
    team { "Atropia" }
    games { "2016 Summer" }
    sport { "Underwater Basket Weaving" }
  end
end