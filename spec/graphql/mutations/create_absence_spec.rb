require 'rails_helper'

RSpec.describe Mutations::CreateAbsence, type: :request do
  describe '.resolve' do
    let(:user) { FactoryBot.create(:user) }
    it 'creates an absence' do
      post '/graphql', params: { query: query(user_id: user.id) }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        {
          'data' => {
            'createAbsence' => {
              'absence' => {
                'id' => '1'
              },
              'errors' => []
            }
          }
        }
      )
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
