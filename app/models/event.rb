class Event < ApplicationRecord
    has_many :athlete_events
    has_many :athletes, through: :athlete_events

    validates :name, presence: true, uniqueness: true

    def self.find_by_sport(sport)
        where("events.name LIKE ?", "%#{sport}%").pluck(:name)
    end
end
