module Types
  class QueryType < Types::BaseObject
    field :fetch_companies, resolver: Queries::FetchCompanies
    field :fetch_users, resolver: Queries::FetchUsers
    field :fetch_daily_absences, resolver: Queries::FetchDailyAbsences
  end
end
