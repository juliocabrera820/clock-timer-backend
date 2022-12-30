module Types
  module Input
    class WorkdayInputType < Types::BaseInputObject
      argument :user_id, String, required: true
    end
  end
end
