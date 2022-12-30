require 'rails_helper'

RSpec.describe Mutations::CreateWorkday, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    context 'with valid check in and out' do
      it 'creates an check in' do
        post '/graphql', params: { query: attendance_query(user_id: user.id, check: 'check_in') }
        post '/graphql', params: { query: attendance_query(user_id: user.id, check: 'check_out') }
        post '/graphql', params: { query: workday_query(user_id: user.id) }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(
          {
            'data' => {
              'createWorkday' => {
                'workday' => {
                  'id' => '1'
                },
                'errors' => []
              }
            }
          }
        )
      end
    end

    def attendance_query(user_id:, check:)
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

    def workday_query(user_id:)
      <<~GQL
        mutation {
          createWorkday(input: {workdayInput: {userId: "#{user_id}"}}){
            workday{
              id
            }
            errors
          }
        }
      GQL
    end
  end
end
