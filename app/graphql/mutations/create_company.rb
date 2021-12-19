module Mutations
  class CreateCompany < Mutations::BaseMutation
    argument :company_input, Types::Input::CompanyInputType, required: true

    field :company, Types::CompanyType, null: false
    field :errors, [String], null: false

    def resolve(company_input:)
      company_params = Hash company_input
      company = Company.new(company_params)

      if company.save
        { company: company, errors: [] }
      else
        raise GraphQL::ExecutionError, company.errors.full_messages
      end
    end
  end
end
