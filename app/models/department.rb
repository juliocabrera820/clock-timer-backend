class Department < ApplicationRecord
  has_many :users, dependent: :destroy
end
