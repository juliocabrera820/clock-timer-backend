module Mutations
  class CreateWorkday < Mutations::BaseMutation
    argument :workday_input, Types::Input::WorkdayInputType, required: true

    field :workday, Types::WorkdayType, null: false
    field :errors, [String], null: false

    def resolve(workday_input:)
      workday_params = Hash workday_input
      workday = Workday.new(workday_params)

      raise GraphQL::ExecutionError, workday.errors.full_messages unless workday.save

      { workday: workday, errors: [] }
    end
  end
end
