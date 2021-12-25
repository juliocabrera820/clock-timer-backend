require 'rails_helper'

RSpec.describe Mutations::CreateCompany, type: :request do
  describe '.resolve' do
    it 'creates a company' do
      post '/graphql', params: { query: query(name: 'bus', address: 'c 34 saint') }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        {
          'data' => {
            'createCompany' => {
              'company' => {
                'id' => '3',
                'name' => 'bus',
                'address' => 'c 34 saint'
              },
              'errors' => []
            }
          }
        }
      )
    end

    def query(name:, address:)
      <<~GQL
        mutation {
          createCompany(input: {companyInput: {name: "#{name}", address: "#{address}"}}){
            company{
              id
              name
              address
            }
            errors
          }
        }
      GQL
    end
  end
end
