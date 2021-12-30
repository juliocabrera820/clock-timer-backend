class User < ApplicationRecord
  belongs_to :company
  has_many :absences, dependent: :destroy
  has_many :attendances, dependent: :destroy
end
