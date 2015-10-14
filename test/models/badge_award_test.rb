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

    b = create(:badge)
    bp = create(:badge_practice, guideline: g, implementation: 2, badge: b)

    p = create(:practice, guideline: g, company: c, implementation: 2)
    assert_equal 1,c.badge_awards.count
  end

  test "test badge award update after practice deletion" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    b = create(:badge)
    bp = create(:badge_practice, guideline: g, implementation: 2, badge: b)

    p = create(:practice, guideline: g, company: c, implementation: 2)
    assert_equal 1,c.badge_awards.count

    p.destroy
    assert_equal 0,c.badge_awards.count
  end

  test "test badge award update after practice update and lose badge" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    b = create(:badge)
    bp = create(:badge_practice, guideline: g, implementation: 3, badge: b)

    p = create(:practice, guideline: g, company: c, implementation: 3)
    assert_equal 1,c.badge_awards.count

    p.update({:implementation => 4})
    assert_equal 0,c.badge_awards.count
  end

  test "test badge award update after practice update and gain badge" do
    g = create(:guideline)
    c = create(:company)
    assert_equal 0,c.badge_awards.count

    b = create(:badge)
    bp = create(:badge_practice, guideline: g, implementation: 2, badge: b)
    assert_equal 0,c.badge_awards.count

    p = create(:practice, guideline: g, company: c, implementation: 3)
    assert_equal 0,c.badge_awards.count

    p.update({:implementation => 2})
    assert_equal 1,c.badge_awards.count
  end

  test "badge award update after badge practice added and removed" do
    g = create(:guideline)

    c = create(:company)
    assert_equal 0, BadgeAward.count


    3.times do
      c = create(:company)
      p = create(:practice, guideline: g, company: c, implementation: 1)
    end

    b = create(:badge)
    assert_equal false, b.needs_to_rebuild
    bp = create(:badge_practice, guideline: g, implementation: 1, badge: b)
    assert_equal true, b.needs_to_rebuild

    # Dummy out other badge_practice so that when there is another BP left after deletion
#    g2 = create(:guideline)
#    bp2 = create(:badge_practice, guideline: g2, implementation: 4, badge: b)

    assert_equal 0, BadgeAward.count
    b.rebuild_awards!
    assert_equal false, b.needs_to_rebuild
    assert_equal 3, BadgeAward.count

    bp.destroy

    assert_equal true, b.needs_to_rebuild
    assert_equal 3, BadgeAward.count
    b.rebuild_awards!
    assert_equal false, b.needs_to_rebuild
    assert_equal 0, BadgeAward.count

  end

end
