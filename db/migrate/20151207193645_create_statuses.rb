class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :logged_in
      t.datetime :logged_out

      t.timestamps null: false
    end
  end
end
