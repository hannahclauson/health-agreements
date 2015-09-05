module ApplicationHelper

  def header_links(this_page=nil)
    # Will make it a smart header later
    links = {
      :home => "/",
      :companies => companies_path,
      :guidelines => guidelines_path,
      :glossary => "/documents/glossary"
    }.reject {|k,v| true if k == this_page }
  end

  def footer_links
    links = {
      "Terms of Service" => "/documents/terms_of_service"
    }
  end

end
