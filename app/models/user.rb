class User < ApplicationRecord
  belongs_to :company
  has_many :absences
  has_many :attendances
end
