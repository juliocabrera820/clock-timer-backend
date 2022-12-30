module Mutations
  class CreateAttendance < Mutations::BaseMutation
    argument :attendance_input, Types::Input::AttendanceInputType, required: true

    field :attendance, Types::AttendanceType, null: false
    field :errors, [String], null: false

    START_HOUR = '9:00'
    END_HOUR = '18:00'
    TIME_FORMAT = '%H:%M'
    CHECK_IN = 'check_in'
    CHECK_OUT = 'check_out'

    def resolve(attendance_input:)
      attendance_params = Hash attendance_input
      attendance = Attendance.new(attendance_params)
      user = User.find(attendance_params[:user_id])
      attendance_handler = AttendanceHandler.new(attendance, user)
      attendance_handler.handle

      raise GraphQL::ExecutionError, attendance.errors.full_messages unless attendance.save

      { attendance: attendance, errors: [] }
    end

    class AttendanceHandler
      attr_reader :attendance_type, :user

      def initialize(attendance, user)
        @attendance = attendance
        @user = user
      end

      def handle
        if @attendance.check == CHECK_IN
          valid_check_in?
        else
          valid_check_out?
        end
      end

      def valid_check_in?
        unless valid_check_in_time?
          Absence.create(user_id: @user.id)
          raise Errors::InvalidCheckedInError
        end
        raise Errors::CheckedInAgainError unless unique_check?(CHECK_IN)

        true
      end

      def valid_check_in_time?
        Time.zone.now <= Time.zone.parse(START_HOUR)
      end

      def unique_check?(type)
        @user.attendances.where(attendances: { check: type }).count < 1
      end

      def checked_in?
        @user.attendances.where(attendances: { check: CHECK_IN }).count == 1
      end

      def valid_check_out?
        raise Errors::WithoutCheckIn unless checked_in?
        raise Errors::CheckedOutBeforeError unless valid_check_out_time?
        raise Errors::CheckedOutAgainError unless unique_check?(CHECK_OUT)

        true
      end

      def valid_check_out_time?
        Time.zone.now >= Time.zone.parse(END_HOUR)
      end
    end
  end
end
