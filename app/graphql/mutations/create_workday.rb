module Mutations
  class CreateWorkday < Mutations::BaseMutation
    argument :workday_input, Types::Input::WorkdayInputType, required: true

    field :workday, Types::AttendanceType, null: false
    field :errors, [String], null: false

    def resolve(workday_input:)
      workday_params = Hash workday_input
      #       Validaciones para que se considere un día de trabajo (mismo día)
      #       - Haber hecho check in a tiempo (a partir de las 9:01 ya es llegar tarde)
      #       - Haber hecho check out a partir de las 6

      workday = Workday.new(workday_params)

      raise GraphQL::ExecutionError, workday.errors.full_messages unless workday.save

      { workday: workday, errors: [] }
    end
  end
end
