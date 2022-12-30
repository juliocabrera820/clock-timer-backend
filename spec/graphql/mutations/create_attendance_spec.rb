require 'rails_helper'

RSpec.describe Mutations::CreateAttendance, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    valid_check_in_time = Time.zone.local(2022, 9, 20, 7, 0, 0) # 7:00 AM
    invalid_check_in_time = Time.zone.local(2022, 9, 20, 9, 1, 0) # 9:01 AM
    valid_check_out_time = Time.zone.local(2022, 9, 20, 18, 0, 0) # 18:00 PM
    invalid_check_out_time = Time.zone.local(2022, 9, 20, 17, 59, 0) # 17:59 PM

    after do
      Timecop.return
    end

    context 'with attendance of check in type' do
      before do
        Timecop.freeze(valid_check_in_time)
      end

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

    context 'when the employee has checked in and out successfully' do
      before do
        Timecop.freeze(valid_check_in_time)
      end

      it 'returns 2 attendances' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
        Timecop.travel(valid_check_out_time)
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }

        formatted_response = JSON.parse(response.body)['data']['createAttendance']
        attendance = formatted_response['attendance']
        errors = formatted_response['errors']

        expect(response).to have_http_status(:ok)
        expect(errors.size).to eq(0)
        expect(attendance).to be_present
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(2)
      end
    end

    context 'when employee wants to check out but he did not check in' do
      before do
        Timecop.freeze(valid_check_out_time)
      end

      it 'raises an exception of type WithoutCheckIn' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado no hizo check in')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(0)
      end
    end

    context 'when the employee was late at check in' do
      before do
        Timecop.freeze(invalid_check_in_time)
      end

      it 'creates an absence and raises an exception of type InvalidCheckedInError' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado llegó tarde')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(1)
        expect(user.reload.attendances.count).to eq(0)
      end
    end

    context 'when the employee checks in again' do
      before do
        Timecop.freeze(valid_check_in_time)
      end

      it 'raises an exception of type CheckedInAgainError' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado quiso registrar su entrada nuevamente')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(1)
      end
    end

    context 'when the employee has absence and wants to check out' do
      before do
        Timecop.freeze(invalid_check_in_time)
      end

      it 'raises an exception of type AbsenceError' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado tiene una falta hoy')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(1)
        expect(user.reload.attendances.count).to eq(0)
      end
    end

    context 'when the employee wants to check out early' do
      before do
        Timecop.freeze(valid_check_in_time)
      end

      it 'raises an exception of type CheckedOutBeforeError' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
        Timecop.travel(invalid_check_out_time)
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado registró su salida antes')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(1)
      end
    end

    context 'when the employee wants to check out again', focus: true do
      before do
        Timecop.freeze(valid_check_in_time)
      end

      it 'raises an exception to type CheckedOutAgainError' do
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_in') }
        Timecop.travel(valid_check_out_time)
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }
        post '/graphql', params: { query: query(user_id: user.id, check: 'check_out') }

        formatted_response = JSON.parse(response.body)
        errors = formatted_response['errors']
        attendance = formatted_response['data']['attendance']

        expect(response).to have_http_status(:ok)
        expect(errors[0]['message']).to eq('El empleado quiso registrar su salida nuevamente')
        expect(attendance).to be_nil
        expect(user.reload.absences.count).to eq(0)
        expect(user.reload.attendances.count).to eq(2)
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
