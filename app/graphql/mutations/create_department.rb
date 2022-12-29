module Mutations
  class CreateDepartment < Mutations::BaseMutation
    argument :department_input, Types::Input::DepartmentInputType, required: true

    field :department, Types::DepartmentType, null: false
    field :errors, [String], null: false

    def resolve(department_input:)
      department_params = Hash department_input
      department = Department.new(department_params)

      raise GraphQL::ExecutionError, department.errors.full_messages unless department.save

      { department: department, errors: [] }
    end
  end
end
