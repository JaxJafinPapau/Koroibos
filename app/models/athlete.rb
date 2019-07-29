class Athlete < ApplicationRecord
    has_many :athlete_events
    has_many :events, through: :athlete_events

    validates :name, presence: true, uniqueness: true

    def total_medals_won
        athlete_events.where.not(medal: "na").count
    end
end
