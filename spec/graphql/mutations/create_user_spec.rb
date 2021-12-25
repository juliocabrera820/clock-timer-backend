require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  describe '.resolve' do
    let(:company) { FactoryBot.create(:company) }
    it 'creates a user' do
      post '/graphql', params: { query: query(name: 'bus', email: 'bus@gmail.com', company_id: company.id) }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        {
          'data' => {
            'createUser' => {
              'user' => {
                'id' => '3',
                'name' => 'bus',
                'email' => 'bus@gmail.com'
              },
              'errors' => []
            }
          }
        }
      )
    end

    def query(name:, email:, company_id:)
      <<~GQL
        mutation {
          createUser(input: {userInput: {name: "#{name}", email: "#{email}", companyId: "#{company_id}"}}){
            user{
              id
              name
              email
            }
            errors
          }
        }
      GQL
    end
  end
end
