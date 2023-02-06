require 'rails_helper'

RSpec.describe Mutations::CreateDepartment, type: :request do
  describe '.resolve' do
    it 'creates a department' do
      post '/graphql', params: { query: query(name: 'bus') }

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('create_department')
    end

    def query(name:)
      <<~GQL
        mutation {
          createDepartment(input: {departmentInput: {name: "#{name}"}}){
            department{
              id
              name
            }
            errors
          }
        }
      GQL
    end
  end
end
