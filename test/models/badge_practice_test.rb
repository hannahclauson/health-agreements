require 'test_helper'

class BadgePracticeTest < ActiveSupport::TestCase

  test "dependent destroy via guideline" do
    g = create(:guideline)

    count = 0

    4.times do
      b = create(:badge)

      create(:badge_practice, guideline: g, badge: b)

      count = BadgePractice.count
    end

    g.destroy

    assert_equal count-4, BadgePractice.count
  end

  test "dependent destroy via badge" do
    count = 0
    b = create(:badge)

    4.times do
      g = create(:guideline)
      create(:badge_practice, guideline: g, badge: b)
    end

    count = BadgePractice.count
    b.destroy

    assert_equal count-4, BadgePractice.count
  end

end
