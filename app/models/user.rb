class User < ApplicationRecord
  has_many :reported_issues, class_name: 'Issue', foreign_key: 'reporter_id'
  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id'

  validates :name, :email, presence: true

end
