require 'test_helper'

class ArchetypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "presence of practices" do
    a = Archetype.new({:name => "Test", :description => "Foo"})

    assert_not a.save
  end
end
