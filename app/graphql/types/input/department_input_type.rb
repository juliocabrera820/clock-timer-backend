module Types
  module Input
    class DepartmentInputType < Types::BaseInputObject
      argument :name, String, required: true
    end
  end
end
