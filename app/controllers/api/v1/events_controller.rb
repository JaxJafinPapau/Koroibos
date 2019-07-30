class Api::V1::EventsController < ApplicationController
    def index
        sports = Athlete.all_unique_sports
        events = EventSerializer.new(sports)
        render status: 200, json: { events: events.serialize }
    end
end