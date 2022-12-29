require 'rails_helper'

RSpec.describe Queries::FetchDepartments, type: :request do
  describe '.resolver' do
    it 'retrieves all departments' do
      create_list(:random_department, 3)
      post '/graphql', params: { query: query }

      data = JSON.parse(response.body, symbolize_names: true)
      departments = data.dig(:data, :fetchDepartments)

      expect(response).to have_http_status(:ok)
      expect(departments.size).to eq 3
    end

    def query
      <<~GQL
        query {
          fetchDepartments{
            id
            name
          }
        }
      GQL
    end
  end
end
