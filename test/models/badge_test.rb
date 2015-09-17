require 'test_helper'

class BadgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
=begin

  test "dependent destroy via company" do
    p = badges(:one)
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
=end
end
