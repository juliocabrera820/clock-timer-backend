require 'rails_helper'

RSpec.describe Mutations::CreateWorkday, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    context 'with valid check in and out' do
      it 'creates a workday' do
        create(:attendance, user: user, check: 'check_in')
        create(:attendance, user: user, check: 'check_out')
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
