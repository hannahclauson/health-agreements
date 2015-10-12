require 'test_helper'

class PracticeTest < ActiveSupport::TestCase
  test "dependent destroy via guideline" do
    g = create(:guideline)
    ps = create_list(:practice, 4, guideline: g)

    count = Practice.count
    g.destroy

    assert_equal count-4, Practice.count
  end

  test "dependent destroy via company" do
    g = create(:guideline)
    c = create(:company)
    ps = create_list(:practice, 2, guideline: g, company: c)

    count = Practice.count
    c.destroy

    assert_equal count-2, Practice.count
  end

end
