module Types
  module Input
    class AbsenceInputType < Types::BaseInputObject
      argument :user_id, String, required: true
    end
  end
end
