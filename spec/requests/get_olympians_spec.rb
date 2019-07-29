require 'rails_helper'

describe "GET api/v1/olympians" do
    it 'should return all the athletes in the specified format' do
        create_list(:athlete, 5)

        get '/api/v1/olympians'

        expect(response.status).to eq(200)
    end
end