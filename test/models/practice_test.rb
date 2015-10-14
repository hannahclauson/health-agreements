require 'test_helper'

class PracticeTest < ActiveSupport::TestCase
  test "dependent destroy via guideline" do
    g = create(:guideline)

    4.times do
      c = create(:company)
      create(:practice, guideline: g, company: c)
    end

    count = Practice.count
    g.destroy

    assert_equal count-4, Practice.count
  end

  test "dependent destroy via company" do
    c = create(:company)

    2.times do
      g = create(:guideline)
      create(:practice, guideline: g, company: c)
    end

    count = Practice.count
    c.destroy

    assert_equal count-2, Practice.count
  end

end
