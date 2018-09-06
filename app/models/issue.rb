class Issue < ApplicationRecord
  STATUSES = [:reported, :assigned, :pending, :resolved]
  SORT_OPTIONS = {'oldest' => :asc, 'newest' => :desc}
  DEFAULT_PER_PAGE = 15
  DEFAULT_SORT = SORT_OPTIONS['newest']

  enum status: STATUSES

  belongs_to :reporter, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  validates :summary, :reporter_id, :assignee_id, presence: true

  def self.filter(filters = {})
    page = filters[:page].blank? ? 1 : filters[:page]
    per_page = filters[:per_page].blank? ? DEFAULT_PER_PAGE : filters[:per_page]
    order_by = SORT_OPTIONS[filters[:order_by]].blank? ? DEFAULT_SORT : SORT_OPTIONS[filters[:order_by]]

    where('summary LIKE ?', "%#{filters[:summary]}%").includes(:reporter, :assignee)
    .joins('INNER JOIN users as reporter ON issues.reporter_id = reporter.id')
    .joins('INNER JOIN users as assignee ON issues.assignee_id = assignee.id')
    .where('reporter.name LIKE ?' ,"%#{filters[:reporter_name]}%")
    .where('assignee.name LIKE ?' ,"%#{filters[:assignee_name]}%")
    .paginate(page: page, per_page: per_page)
    .order('created_at' => order_by)
  end
end
