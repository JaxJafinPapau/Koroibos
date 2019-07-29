require 'rails_helper'

describe "GET api/v1/olympians?age=????" do
    it 'should return the youngest athlete when age=youngest' do
        create(:athlete, age: 3)
        create(:athlete, age: 4)
        create(:athlete, age: 96)

        create_list(:event, 4)

        winner = Athlete.where(age: 3).first
        winner.events << Event.first
        winner.events << Event.second

        AthleteEvent.first.update(medal: 1)

        get '/api/v1/olympians?age=youngest'

        expect(response.status).to eq(200)

        olympian = JSON.parse(response.body)
        
        expect(olympian).to be_a(Hash)
        expect(olympian['olympians'].first['id']).to eq(winner.id)
        expect(olympian['olympians'].first['age']).to eq(3)
        expect(olympian['olympians'].first['sport']).to eq('Underwater Basket Weaving')
    end

    it 'should return the oldest athlete when age=oldest' do
        create(:athlete, age: 3)
        create(:athlete, age: 4)
        create(:athlete, age: 96)

        create_list(:event, 4)

        winner = Athlete.where(age: 96).first
        winner.events << Event.first
        winner.events << Event.second

        AthleteEvent.first.update(medal: 1)

        get '/api/v1/olympians?age=oldest'

        expect(response.status).to eq(200)

        olympian = JSON.parse(response.body)
        
        expect(olympian).to be_a(Hash)
        expect(olympian['olympians'].first['id']).to eq(winner.id)
        expect(olympian['olympians'].first['age']).to eq(96)
        expect(olympian['olympians'].first['sport']).to eq('Underwater Basket Weaving')
    end

    #sad path
    
    it 'should return 404 with proper error with no athletes' do
        get '/api/v1/olympians'
        
        error = JSON.parse(response.body)

        expect(error['error']).to eq("No Olympians found.")
    end
end