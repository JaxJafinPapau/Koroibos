class Event < ApplicationRecord
    has_many :athlete_events
    has_many :athletes, through: :athlete_events

    validates :name, presence: true
end
