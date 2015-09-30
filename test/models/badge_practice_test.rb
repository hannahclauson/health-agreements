require 'test_helper'

class BadgePracticeTest < ActiveSupport::TestCase

  test "dependent destroy via guideline" do
    g = create(:guideline)
    ps = create_list(:badge_practice, 4, guideline: g)

    count = BadgePractice.count
    g.destroy

    assert_equal count-4, BadgePractice.count
  end

  test "dependent destroy via badge" do
    b = create(:badge)
    ps = create_list(:badge_practice, 4, badge: b)

    count = BadgePractice.count
    b.destroy

    assert_equal count-4, BadgePractice.count
  end

end
