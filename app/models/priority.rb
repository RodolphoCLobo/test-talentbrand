class Priority < ApplicationRecord
  validates_presence_of :status
  has_many :notes
end
