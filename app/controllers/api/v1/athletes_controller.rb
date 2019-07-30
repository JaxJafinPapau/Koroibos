class Api::V1::AthletesController < ApplicationController
    def index
        if params['age']
            olympians = Athlete.oldest_or_youngest(params['age']).map { |o| serialize_athlete(o) }
            # olympians = Athlete.order(age: :desc).limit(1).map { |a| serialize_athlete(a) }
        elsif !params['age']
            olympians = Athlete.with_total_medals_won.map { |o| serialize_athlete(o) }
        end
        render status: 200, json: { olympians: olympians } if olympians.first
        render status: 404, json: { error: "No Olympians found."} if !olympians.first
    end

    private

        def serialize_athlete(athlete)!!!
            olympian = OlympianSerializer.new(athlete)
            olympian.serialize
        end
end