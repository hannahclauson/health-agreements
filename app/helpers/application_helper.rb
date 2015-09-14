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

  def access_to_action(action)
    # Everyone can view

    puts "Editor access level? #{editor_access_level?}"

    if !editor_access_level?
      case action
      when :show
        return true
      when :index
        return true
      else
        return false
      end
    end

    # Editors can :edit

    if editor_access_level?
      case action
      when :new
        return true
      when :edit
        return true
      else
        return false
      end
    end

    # Admins can :delete

    puts "Admin access level? #{admin_access_level?}"

    if admin_access_level?
      return true
    end

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
