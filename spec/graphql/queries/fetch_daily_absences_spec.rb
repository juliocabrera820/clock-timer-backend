require 'rails_helper'

RSpec.describe Queries::FetchDailyAbsences, type: :request do
  describe '.resolver' do
    it 'retrieves daily absences' do
      FactoryBot.create_list(:random_absence, 4)
      post '/graphql', params: { query: query }
      data = JSON.parse(response.body, symbolize_names: true)
      absences = data.dig(:data, :fetchDailyAbsences)
      expect(response).to have_http_status(:ok)
      expect(absences.size).to eq 4
    end

    def query
      <<~GQL
        query {
          fetchDailyAbsences {
            id
            createdAt
          }
        }
      GQL
    end
  end
end
