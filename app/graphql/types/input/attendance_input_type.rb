module Types
  module Input
    class AttendanceInputType < Types::BaseInputObject
      argument :user_id, String, required: true
    end
  end
end
