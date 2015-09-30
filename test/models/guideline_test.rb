require 'test_helper'

class GuidelineTest < ActiveSupport::TestCase

  test "cannot save w empty obj" do
    g = Guideline.new
    assert_not g.save
  end



  test "cannot save without name" do
    g = Guideline.new({
                        :name => "", 
                        :description => "1234567890",
                        :true_description => "This is a thing thats true",
                        :false_description => "This is a thing thats false"})
    assert_not g.save
  end

  test "cannot save without description" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :true_description => "This is a thing thats true",
                        :false_description => "This is a thing thats false"})
    assert_not g.save
  end

  test "cannot save without description of length 10" do
    g = Guideline.new({
                        :name => "abba zabba", 
                        :description => "123456789",
                        :true_description => "This is a thing thats true",
                        :false_description => "This is a thing thats false"})
    assert_not g.save
  end

  test "cannot save without a true description of length 10" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :description => "123456789",
                        :true_description => "This ",
                        :false_description => "This is a thing thats false"})
    assert_not g.save
  end

  test "cannot save without a true description" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :description => "123456789",
                        :false_description => "This is a thing thats false"})
    assert_not g.save
  end

  test "cannot save without a false description" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :description => "1234567890",
                        :true_description => "This is a thing thats true"})
    assert_not g.save
  end

  test "cannot save without a false description of length 10" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :description => "1234567890",
                        :true_description => "This is a thing thats true",
                        :false_description => "This "})
    assert_not g.save
  end

  test "valid save" do
    g = Guideline.new({
                        :name => "abba zabba",
                        :description => "1234567890",
                        :true_description => "This is a thing thats true",
                        :false_description => "This is a thing thats false"})
    assert g.save
  end

end
