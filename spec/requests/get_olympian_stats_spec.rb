require 'rails_helper'

describe 'GET /api/v1/olympian_stats' do
    it 'should return statistics of the olympians' do
        create(:athlete, age: 3)
        create(:athlete, age: 4)
        create(:athlete, age: 5)
        create(:athlete, age: 3, sex: "F")
        create(:athlete, age: 4, sex: "F")
        create(:athlete, age: 5, sex: "F")

        create_list(:event, 4)

        winner = Athlete.where(age: 3).first
        winner.events << Event.first
        winner.events << Event.second

        AthleteEvent.first.update(medal: 1)

        get '/api/v1/olympian_stats'

        expect(response.status).to eq(200)
        stats = JSON.parse(response.body)

        expect(stats['olympian_stats']).to be_a(Hash)
        expect(stats['olympian_stats']['total_competing_olympians']).to eq(6)
        expect(stats['olympian_stats']['average_weight']['male_olympians']).to eq("70.0")
        expect(stats['olympian_stats']['average_weight']['female_olympians']).to eq("70.0")
        expect(stats['olympian_stats']['average_age']).to eq("4.0")
    end
end