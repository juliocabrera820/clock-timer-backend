require 'rails_helper'

RSpec.describe Mutations::CreateAttendance, type: :request do
  describe '.resolve' do
    let(:user) { FactoryBot.create(:user) }

    context 'with attendance of check in type' do
      it 'creates an check in' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
  
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(
          {
            'data' => {
              'createAttendance' => {
                'attendance' => {
                  'id' => '1',
                  'check' => 'check_in'
                },
                'errors' => []
              }
            }
          }
        )
      end
    end

    context 'with attendance of check out type' do
      it 'creates an check out' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }
  
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(
          {
            'data' => {
              'createAttendance' => {
                'attendance' => {
                  'id' => '2',
                  'check' => 'check_out'
                },
                'errors' => []
              }
            }
          }
        )
      end
    end

    def query(user_id:, check:)
      <<~GQL
        mutation {
          createAttendance(input: {attendanceInput: {userId: "#{user_id}", check: "#{check}"}}){
            attendance{
              id
              check
            }
            errors
          }
        }
      GQL
    end
  end
end
