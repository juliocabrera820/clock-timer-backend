module Types
  class MutationType < Types::BaseObject
    field :create_company, mutation: Mutations::CreateCompany
    field :create_user, mutation: Mutations::CreateUser
    field :create_absence, mutation: Mutations::CreateAbsence
    field :create_attendance, mutation: Mutations::CreateAttendance
  end
end
