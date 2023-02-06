require 'rails_helper'

RSpec.describe Mutations::CreateWorkday, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    valid_check_in_time = Time.zone.local(2022, 9, 20, 7, 0, 0) # 7:00 AM
    valid_check_out_time = Time.zone.local(2022, 9, 20, 18, 0, 0) # 18:00 PM

    context 'with valid check in and out' do
      before do
        Timecop.freeze(valid_check_in_time)
      end

      it 'creates a workday' do
        post '/graphql', params: { query: attendance_query(user_id: user.id, check: 'check_in') }
        Timecop.travel(valid_check_out_time)
        post '/graphql', params: { query: attendance_query(user_id: user.id, check: 'check_out') }
        post '/graphql', params: { query: workday_query(user_id: user.id) }

        formatted_response = JSON.parse(response.body)['data']['createWorkday']
        workday = formatted_response['workday']
        errors = formatted_response['errors']

        expect(response).to have_http_status(:ok)
        expect(errors.size).to eq(0)
        expect(workday).to be_present
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(2)
        expect(user.reload.workdays.count).to eq(1)
        expect(response).to match_response_schema('create_workday')
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
