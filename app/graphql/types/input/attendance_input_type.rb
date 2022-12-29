module Types
  module Input
    class AttendanceInputType < Types::BaseInputObject
      argument :user_id, String, required: true
      argument :check, String, required: true
    end
  end
end
