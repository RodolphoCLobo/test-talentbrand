class Note < ApplicationRecord
  validates_presence_of :title, :body, :user_id, :priority_id
  belongs_to :user
  belongs_to :priority
end
