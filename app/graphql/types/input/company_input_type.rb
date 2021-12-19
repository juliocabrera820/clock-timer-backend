module Types
  module Input
    class CompanyInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :address, String, required: true
    end
  end
end
