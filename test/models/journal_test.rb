require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "count" do
    create_list(:journal, 2)
    assert_equal 2, Journal.count
  end

  test "cannot save without name" do
    c = Journal.new({
                      :impact_factor => 3.4,
                      :url => "http://seomtoh.com"
                    })
    assert_not c.save
  end

  test "cannot save with too short a name" do
    c = Journal.new({
                      :name => "a",
                      :url => "http://asite.com"
                    })
    assert_not c.save
  end

  test "cannot save with invalid URL" do
    c = Journal.new({
                      :name => "abba",
                      :url => "!!!KQ#U$(SUDMFZLBKJ//asite.com",
                      :impact_factor => 3.4
                    })
    assert_not c.save
  end

  test "cannot save with missing URL" do
    c = Journal.new({
                      :name => "abba",
                      :impact_factor => 3.4
                    })
    assert_not c.save
  end

  test "valid save" do
    c = Journal.new({
                      :name => "abba",
                      :url => "http://asite.com",
                      :impact_factor => 3.4
                    })
    assert c.save
  end

end
