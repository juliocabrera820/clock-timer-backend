require 'rails_helper'

RSpec.describe Mutations::CreateAbsence, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    it 'creates an absence' do
      post '/graphql', params: { query: query(user_id: user.id) }

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('create_absence')
    end

    def query(user_id:)
      <<~GQL
        mutation {
          createAbsence(input: {absenceInput: {userId: "#{user_id}"}}){
            absence{
              id
            }
            errors
          }
        }
      GQL
    end
  end
end
