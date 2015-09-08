module ApplicationHelper

  def active_page
    self.page_class.split(" ").join("_").to_sym
  end

  def header_links
    {
      :companies_index => ['Companies', companies_path], # companies index
      :guidelines_index => ['Guidelines', guidelines_path], #guidelines index
      :documents_glossary => ['Glossary', "/documents/glossary"] #documents glossary
    }
  end

  def footer_links
    links = {
      "Terms of Service" => "/documents/terms_of_service",
      "Glossary" => "/documents/glossary",
      "Credit" => "/documents/credit"
    }
  end

end
