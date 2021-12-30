require 'rails_helper'

RSpec.describe Queries::FetchCompanies, type: :request do
  describe '.resolver' do
    it 'retrieves all companies' do
      FactoryBot.create_list(:random_company, 3)
      post '/graphql', params: { query: query }
      data = JSON.parse(response.body, symbolize_names: true)
      companies = data.dig(:data, :fetchCompanies)
      expect(response).to have_http_status(:ok)
      expect(companies.size).to eq 3
    end

    def query
      <<~GQL
        query {
          fetchCompanies{
            id
            name
            address
          }
        }
      GQL
    end
  end
end
