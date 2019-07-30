require 'rails_helper'

describe 'GET api/v1/events' do
   it 'should return the events' do
    athlete_1 = create(:athlete, sport: "Badminton", sex: "M")
    athlete_2 = create(:athlete, sport: "Badminton", sex: "F")
    athlete_3 = create(:athlete, sport: "Archery", sex: "F")
    athlete_4 = create(:athlete, sport: "Archery", sex: "M")

    athlete_1.events.create(name: "Badminton Mixed Doubles")
    athlete_2.events.create(name: "Badminton Women's Doubles")
    athlete_4.events.create(name: "Archery Men's Individual")
    athlete_3.events.create(name: "Archery Women's Individual")

    get '/api/v1/events'

    expect(response.status).to eq(200)

    events = JSON.parse(response.body)

    expect(events["events"]).to be_a(Array)
    expect(events["events"].first).to have_key("sport")
    expect(events["events"].first).to have_key("events")
    expect(events["events"].first["events"]).to be_a(Array)
   end 
end