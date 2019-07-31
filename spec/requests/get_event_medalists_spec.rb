require 'rails_helper'

describe 'GET /api/v1/events/:id/medalists' do
    it 'should return the medalists for a particular event' do
        create_list(:athlete, 5)

        create_list(:event, 4)

        winner_1 = Athlete.first
        winner_1.events << Event.first
        winner_2 = Athlete.second
        winner_2.events << Event.first
        loser_2 = Athlete.third
        loser_2.events << Event.first; loser_2.events << Event.third
        loser_3 = Athlete.fourth
        loser_3.events << Event.second; loser_3.events << Event.third
        loser_4 = Athlete.fifth
        loser_4.events << Event.second; loser_4.events << Event.third

        winner_1.athlete_events.first.update(medal: 1)
        winner_2.athlete_events.first.update(medal: 2)

        event_id = Event.first.id
        get "/api/v1/events/#{event_id}/medalists"

        expect(response.status).to eq(200)

        medalists = JSON.parse(response.body)

        expect(medalists['event']).to eq(Event.first.name)
        expect(medalists['medalists']).to be_a(Array)
        expect(medalists['medalists'].first['medal']).to_not eq("na")
    end

    #sad path
    it 'should return the proper error message when event is not found' do
        create_list(:athlete, 5)

        create_list(:event, 4)

        winner_1 = Athlete.first
        winner_1.events << Event.first
        winner_2 = Athlete.second
        winner_2.events << Event.first
        loser_2 = Athlete.third
        loser_2.events << Event.first; loser_2.events << Event.third
        loser_3 = Athlete.fourth
        loser_3.events << Event.second; loser_3.events << Event.third
        loser_4 = Athlete.fifth
        loser_4.events << Event.second; loser_4.events << Event.third

        winner_1.athlete_events.first.update(medal: 1)
        winner_2.athlete_events.first.update(medal: 2)

        event_id = Event.last.id + 2008
        get "/api/v1/events/#{event_id}/medalists"

        expect(response.status).to eq(404)

        error = JSON.parse(response.body)

        expect(error['error']).to eq("Event not found.")
    end
end