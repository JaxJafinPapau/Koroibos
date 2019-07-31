class MedalistsSerializer
    def initialize(event, athlete_events)
        @event = event
        @athlete_events = athlete_events
    end

    def serialize
        { event: @event.name,
          medalists: load_medalist_data       
        }
    end

    private

        def load_medalist_data
            @athlete_events.map do |medalist|
                { name: medalist.name,
                  team: medalist.team,
                  age: medalist.age,
                  medal: medalist.medal 
                }
            end
        end

end