class User < ApplicationRecord
  belongs_to :department
  has_many :absences, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :workdays, dependent: :destroy

  validates :name, presence: true
end
