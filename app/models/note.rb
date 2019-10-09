class Note < ApplicationRecord
  validates_presence_of :title, :body, :user_id, :priority_id
  belongs_to :user, class_name: 'User'
  belongs_to :priority, class_name: 'Priority'
end
