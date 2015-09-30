require 'test_helper'

class BadgeAwardTest < ActiveSupport::TestCase

  test "dependent destroy via company" do
    c = create(:company)
    bas = create_list(:badge_award, 4, company: c)

    count = BadgeAward.count
    c.destroy

    assert_equal count-4, BadgeAward.count
  end

  test "dependent destroy via badge" do
    b = create(:badge)
    ba = create_list(:badge_award, 4, badge: b)

    count = BadgeAward.count
    b.destroy

    assert_equal count-4, BadgeAward.count
  end

end
