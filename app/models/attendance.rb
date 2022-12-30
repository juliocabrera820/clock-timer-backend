class Attendance < ApplicationRecord
  belongs_to :user

  enum check: %i[check_in check_out]

  validates :check, presence: true
end
