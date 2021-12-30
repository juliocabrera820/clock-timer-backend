module Queries
  class FetchCompanies < Queries::BaseQuery
    type [Types::CompanyType], null: false

    def resolve
      Company.all
    end
  end
end
