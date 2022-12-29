require 'rails_helper'

RSpec.describe Queries::FetchUsers, type: :request do
  describe '.resolver' do
    it 'retrieves all users' do
      FactoryBot.create_list(:random_user, 3)
      post '/graphql', params: { query: query }

      data = JSON.parse(response.body, symbolize_names: true)
      users = data.dig(:data, :fetchUsers)

      expect(response).to have_http_status(:ok)
      expect(users.size).to eq 3
    end

    def query
      <<~GQL
        query {
          fetchUsers{
            id
            name
            email
          }
        }
      GQL
    end
  end
end
