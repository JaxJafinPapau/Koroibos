require 'rails_helper'

describe "GET api/v1/olympians" do
    it 'should return all the athletes in the specified format' do
        create_list(:athlete, 5)

        create_list(:event, 4)

        winner = Athlete.first
        winner.events << Event.first
        winner.events << Event.second

        AthleteEvent.first.update(medal: 1)

        get '/api/v1/olympians'

        expect(response.status).to eq(200)

        olympians = JSON.parse(response.body)
        
        expect(olympians).to be_a(Hash)
        expect(olympians['olympians'].count).to eq(5)
        expect(olympians['olympians'].first['total_medals_won']).to eq(1)
        expect(olympians['olympians'].second['total_medals_won']).to eq(0)
        expect(olympians['olympians'].sample['sport']).to eq('Underwater Basket Weaving')
    end

    #sad path
    
    it 'should return 404 with proper error with no athletes' do
        get '/api/v1/olympians'
        
        error = JSON.parse(response.body)

        expect(error['error']).to eq("No Olympians found.")
    end
end