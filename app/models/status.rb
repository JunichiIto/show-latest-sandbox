class Status < ActiveRecord::Base
  belongs_to :user

  scope :latest_by_user, -> {
    sub_query = <<-SQL
SELECT user_id,
       MAX(CASE WHEN logged_out IS NULL THEN logged_in ELSE logged_out END) AS max_datetime
FROM statuses
GROUP BY user_id
    SQL

    join_sql = <<-SQL
INNER JOIN (#{sub_query}) AS sub
ON sub.user_id = statuses.user_id
AND sub.max_datetime = CASE WHEN statuses.logged_out IS NULL THEN statuses.logged_in ELSE statuses.logged_out END
    SQL

    joins(join_sql)
  }
end
