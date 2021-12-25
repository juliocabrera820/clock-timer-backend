module Mutations
  class CreateAttendance < Mutations::BaseMutation
    argument :attendance_input, Types::Input::AttendanceInputType, required: true

    field :attendance, Types::AttendanceType, null: false
    field :errors, [String], null: false

    def resolve(attendance_input:)
      attendance_params = Hash attendance_input
      attendance = Attendance.new(attendance_params)

      if attendance.save
        { attendance: attendance, errors: [] }
      else
        raise GraphQL::ExecutionError, attendance.errors.full_messages
      end
    end
  end
end
