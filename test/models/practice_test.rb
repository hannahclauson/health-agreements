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

  test "dependent destroy via company" do
    p = practices(:one)
    practiceable = p.practiceable # a company
    practiceable_id = practiceable.id

    count = Practice.count
    practiceable.destroy

    assert_equal count-2, Practice.count
  end

  test "dependent destroy via archetype" do
    p = practices(:research_a)
    practiceable = p.practiceable # an archetype
    practiceable_id = practiceable.id

    count = Practice.count
    practiceable.destroy

    assert_equal count-2, Practice.count
  end

end
