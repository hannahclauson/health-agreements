require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "dependent destroy via journal" do
    g = create(:journal)

    4.times do
      c = create(:company)
      create(:article, journal: g, company: c)
    end

    count = Article.count
    g.destroy

    assert_equal count-4, Article.count
  end

  test "dependent destroy via company" do
    c = create(:company)

    2.times do
      g = create(:journal)
      create(:article, journal: g, company: c)
    end

    count = Article.count
    c.destroy

    assert_equal count-2, Article.count
  end

end
