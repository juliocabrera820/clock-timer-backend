module Types
  module Input
    class UserInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
      argument :department_id, String, required: true
    end
  end
end
