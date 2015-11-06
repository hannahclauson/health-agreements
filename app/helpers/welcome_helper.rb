module WelcomeHelper
  def search_params(new_param)
    # Only used on homepage to generate search links
    # - its this or do redundant param walking/checking to see if things exist
    # when I'm populating the search form after a search
    {
      :company => {
        :name => ""
      },
      :badge => {
        :id => "",
        :name => ""
      },
      :guideline => {
        :id => ""
      },
      :practice => {
        :implementation => ""
      },
      :commit => "Search"
    }.merge(new_param)
  end
end
