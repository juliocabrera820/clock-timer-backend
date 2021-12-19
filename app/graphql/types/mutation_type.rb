module Types
  class MutationType < Types::BaseObject
    field :create_company, mutation: Mutations::CreateCompany
  end
end
