require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  describe '.resolve' do
    let(:department) { create(:department) }

    it 'creates a user' do
      post '/graphql', params: { query: query(name: 'bus', email: 'bus@gmail.com', department_id: department.id) }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        {
          'data' => {
            'createUser' => {
              'user' => {
                'id' => '3',
                'name' => 'bus',
                'email' => 'bus@gmail.com'
              },
              'errors' => []
            }
          }
        }
      )
    end

    def query(name:, email:, department_id:)
      <<~GQL
        mutation {
          createUser(input: {userInput: {name: "#{name}", email: "#{email}", departmentId: "#{department_id}"}}){
            user{
              id
              name
              email
            }
            errors
          }
        }
      GQL
    end
  end
end
