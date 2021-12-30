module Types
  class QueryType < Types::BaseObject
    field :fetch_companies, resolver: Queries::FetchCompanies
    field :fetch_users, resolver: Queries::FetchUsers
  end
end
