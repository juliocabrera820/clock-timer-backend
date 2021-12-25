module Mutations
  class CreateAbsence < Mutations::BaseMutation
    argument :absence_input, Types::Input::AbsenceInputType, required: true

    field :absence, Types::AbsenceType, null: false
    field :errors, [String], null: false

    def resolve(absence_input:)
      absence_params = Hash absence_input
      absence = Absence.new(absence_params)

      if absence.save
        { absence: absence, errors: [] }
      else
        raise GraphQL::ExecutionError, absence.errors.full_messages
      end
    end
  end
end
