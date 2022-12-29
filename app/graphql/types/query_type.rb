module Types
  class QueryType < Types::BaseObject
    field :fetch_departments, resolver: Queries::FetchDepartments
    field :fetch_users, resolver: Queries::FetchUsers
    field :fetch_daily_absences, resolver: Queries::FetchDailyAbsences
  end
end
