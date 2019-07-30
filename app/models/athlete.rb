class Athlete < ApplicationRecord
    has_many :athlete_events
    has_many :events, through: :athlete_events

    validates :name, presence: true, uniqueness: true

    def self.with_total_medals_won
        find_by_sql("SELECT SUM(CASE WHEN ae.medal = 0 THEN 0 ELSE 1 END) AS total_medals, a.* FROM athletes a INNER JOIN athlete_events ae ON ae.athlete_id = a.id GROUP BY a.id")
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
    
    def self.all_unique_sports
        pluck(:sport).uniq
    end

    def self.oldest_or_youngest(param)
        if param == "youngest"
            order(age: :asc).limit(1)
        elsif param == "oldest"
            order(age: :desc).limit(1)
        end
    end
end
