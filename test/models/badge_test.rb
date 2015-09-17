require 'test_helper'

class BadgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "dependent destroy via company" do
    c = companies('23andme')

    count = Badge.count
    c.destroy

    assert_equal count-2, Badge.count
  end

  test "dependent destroy via archetype" do
    a = archetypes("research")

    count = Badge.count
    a.destroy

    assert_equal count-2, Badge.count
  end

end
