module Queries
  class FetchDepartments < Queries::BaseQuery
    type [Types::DepartmentType], null: false

    def resolve
      Department.all
    end
  end
end
