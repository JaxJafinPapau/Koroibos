class Api::V1::AthletesController < ApplicationController
    def index
        if params['age'] == "youngest"
            olympians = Athlete.order(age: :asc).limit(1)
        elsif params['age'] == "oldest"
            olympians = Athlete.order(age: :desc).limit(1)
        elsif !params['age']
            olympians = Athlete.all.map do |athlete|
                serialize_athlete(athlete)
            end
        end
        render status: 200, json: { olympians: olympians } if olympians.first
        render status: 404, json: { error: "No Olympians found."} if !olympians.first
    end

    private

        def serialize_athlete(athlete)
            olympian = OlympianSerializer.new(athlete)
            olympian.serialize
        end
end