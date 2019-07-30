class OlympianSerializer
    def initialize(athlete)
        @id = athlete[:id]
        @name = athlete[:name]
        @team = athlete[:team]
        @age = athlete[:age]
        @sport = athlete[:sport]
        @total_medals_won = athlete[:total_medals]
    end

    def serialize
        { id: @id,
          name: @name,
          team: @team,
          age: @age,
          sport: @sport,
          total_medals_won: @total_medals_won
        }
    end
end