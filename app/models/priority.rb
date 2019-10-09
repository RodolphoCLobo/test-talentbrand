class Priority < ApplicationRecord
  validates_presence_of :status
  has_many :notes, class_name: 'Note', dependent: :destroy
end
