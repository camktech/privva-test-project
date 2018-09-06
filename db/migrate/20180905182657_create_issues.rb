class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :summary
      t.integer :status, default: 0
      t.references :reporter
      t.references :assignee

      t.timestamps
    end
  end
end
