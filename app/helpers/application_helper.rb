require 'access_levels'

module ApplicationHelper

  def active_page
    self.page_class.split(" ").join("_").to_sym
  end

  def editor_access_level?
    !current_user.nil? && (current_user.editor? || current_user.admin?)
  end

  def admin_access_level?
    !current_user.nil? && current_user.admin?
  end

  # This method is only used in views (when to show action links)

  def access_to_action(action)
    access = false

    # Editors can :edit
    puts "Editor access level? #{editor_access_level?}"

    if editor_access_level? & (AccessLevels::EDITOR_ACTIONS.include? action)
      access = true
    end

    # Admins can :delete
    puts "Admin access level? #{admin_access_level?}"

    if admin_access_level?
      access = true
    end

    return access
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
