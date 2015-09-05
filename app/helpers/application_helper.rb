module ApplicationHelper

  def header_links(this_page=nil)
    # Will make it a smart header later
    links = {
      :home => "/",
      :companies => companies_path,
      :guidelines => guidelines_path,
      :glossary => "/glossary"
    }.reject {|k,v| true if k == this_page }
  end

end
