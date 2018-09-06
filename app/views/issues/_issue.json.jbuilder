json.extract! issue, :id, :summary, :status, :reporter_id, :assignee_id, :created_at, :updated_at
json.url issue_url(issue, format: :json)
