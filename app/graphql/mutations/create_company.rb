module Mutations
  class CreateCompany < Mutations::BaseMutation
    argument :company_input, Types::Input::CompanyInputType, required: true

    field :company, Types::CompanyType, null: false
    field :errors, [String], null: false

    def resolve(company_input:)
      company_params = Hash company_input
      company = Company.new(company_params)

      raise GraphQL::ExecutionError, company.errors.full_messages unless company.save

      { company: company, errors: [] }
    end
  end
end
