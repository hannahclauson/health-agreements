require 'test_helper'

class PracticeTest < ActiveSupport::TestCase
  test "dependent destroy via guideline" do
    p = practices(:one)
    g = p.guideline
    g_id = g.id

    count = Practice.count
    g.destroy

    assert_equal count-3, Practice.count
  end

end
