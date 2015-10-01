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

  # Badge Updates when Company->Practice changes

  test "test badge award update after practice creation" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    bp = create(:badge_practice, guideline: g, implementation: 2)
    b = create(:badge, badge_practices: [bp])

    p = create(:practice, guideline: g, company: c, implementation: 2)
    assert_equal 1,c.badge_awards.count
  end

  test "test badge award update after practice deletion" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    bp = create(:badge_practice, guideline: g, implementation: 2)
    b = create(:badge, badge_practices: [bp])

    p = create(:practice, guideline: g, company: c, implementation: 2)
    assert_equal 1,c.badge_awards.count

    puts "about to destroy"
    p.destroy
    puts "done destroying"
    assert_equal 0,c.badge_awards.count
  end

  test "test badge award update after practice update and lose badge" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    bp = create(:badge_practice, guideline: g, implementation: 3)
    b = create(:badge, badge_practices: [bp])

    p = create(:practice, guideline: g, company: c, implementation: 3)
    assert_equal 1,c.badge_awards.count

    p.update({:implementation => 4})
    assert_equal 0,c.badge_awards.count
  end

  test "test badge award update after practice update and gain badge" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    bp = create(:badge_practice, guideline: g, implementation: 2)
    b = create(:badge, badge_practices: [bp])
    assert_equal 0,c.badge_awards.count

    p = create(:practice, guideline: g, company: c, implementation: 3)
    assert_equal 0,c.badge_awards.count

    p.update({:implementation => 2})
    assert_equal 1,c.badge_awards.count
  end




end
