class Api::V1::AthletesController < ApplicationController
    def index
        if params['age'] == "youngest"
            olympians = Athlete.order(age: :asc).limit(1).map { |a| serialize_athlete(a) }
        elsif params['age'] == "oldest"
            olympians = Athlete.order(age: :desc).limit(1).map { |a| serialize_athlete(a) }
        elsif !params['age']
            olympians = Athlete.with_total_medals_won
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