require 'rails_helper'

RSpec.describe Mutations::CreateAttendance, type: :request do
  describe '.resolve' do
    let(:user) { FactoryBot.create(:user) }
    it 'creates an attendance' do
      post '/graphql', params: { query: query(user_id: user.id) }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        {
          'data' => {
            'createAttendance' => {
              'attendance' => {
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
          createAttendance(input: {attendanceInput: {userId: "#{user_id}"}}){
            attendance{
              id
            }
            errors
          }
        }
      GQL
    end
  end
end
