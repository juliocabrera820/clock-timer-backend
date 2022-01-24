module Queries
  class FetchDailyAbsences < Queries::BaseQuery
    type [Types::AbsenceType], null: false

    def resolve
      Absence.where(created_at: Time.zone.today.all_day)
    end
  end
end
