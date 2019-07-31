class Api::V1::EventsController < ApplicationController
    def index
        sports = Athlete.all_unique_sports
        events = EventSerializer.new(sports)
        render status: 200, json: { events: events.serialize }
    end

    def show
        begin
            event_id = params['event_id'].to_i
            event = Event.find(event_id)
            event_medalists = AthleteEvent.event_medalists(event_id)
            serialized_medalists = MedalistsSerializer.new(event, event_medalists)
            render status: 200, json: serialized_medalists.serialize
        rescue
            render status: 404, json: { error: "Event not found." }
        end
    end
end