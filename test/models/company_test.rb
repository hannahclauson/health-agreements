require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "count" do
    create_list(:company, 2)
    assert_equal 2, Company.count
  end

  test "cannot save without name" do
    c = Company.new
    assert_not c.save
  end

  test "cannot save with too short a name" do
    c = Company.new({
                      :name => "a",
                      :url => "http://asite.com"
                    })
    assert_not c.save
  end

  test "cannot save with invalid URL" do
    c = Company.new({
                      :name => "abba",
                      :url => "!!!KQ#U$(SUDMFZLBKJ//asite.com"
                    })
    assert_not c.save
  end

  test "cannot save with missing URL" do
    c = Company.new({
                      :name => "abba"
                    })
    assert_not c.save
  end

  test "valid save" do
    c = Company.new({
                      :name => "abba",
                      :url => "http://asite.com"
                    })
    assert c.save
  end

end
