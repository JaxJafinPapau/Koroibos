class Athlete < ApplicationRecord
    has_many :athlete_events
    has_many :events, through: :athlete_events

    validates :name, presence: true, uniqueness: true

    def total_medals_won
        athlete_events.where.not(medal: "na").count
    end

    def self.total_olympians
        all.count
    end

    def self.mean_weight_males
        where(sex: "M").average(:weight)
    end

    def self.mean_weight_females
        where(sex: "F").average(:weight)
    end

    def self.mean_age
        average(:age)
    end
end
