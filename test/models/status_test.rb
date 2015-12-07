require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "ユーザー別に最新のレコードを集計する" do
    alice = User.create!(name: 'Alice')
    bob = User.create!(name: 'Bob')

    alice_status_1 = alice.statuses.create!(logged_in: '2015-01-01 00:00:00', logged_out: '2015-01-01 01:00:00')
    alice_status_2 = alice.statuses.create!(logged_in: '2015-01-02 00:00:00', logged_out: nil) # <= 最新

    bob_status_1 = bob.statuses.create!(logged_in: '2015-01-01 00:00:00', logged_out: '2015-01-31 01:00:00') # <= 最新
    bob_status_2 = bob.statuses.create!(logged_in: '2015-01-02 00:00:00', logged_out: '2015-01-02 01:00:00')

    statuses = Status.latest_by_user.order(:user_id)
    assert_equal [alice_status_2, bob_status_1], statuses
  end
end
