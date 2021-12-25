module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :user_input, Types::Input::UserInputType, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(user_input:)
      user_params = Hash user_input
      user = User.new(user_params)

      if user.save
        { user: user, errors: [] }
      else
        raise GraphQL::ExecutionError, user.errors.full_messages
      end
    end
  end
end
