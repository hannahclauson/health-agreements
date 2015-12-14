module PracticesHelper

  # Seems like it should be in guidelines helper, but it belongs here
  # - This is used only when creating/editing a practice, as only the avail
  # guidelines are valid options
  def enumerated_guidelines
    tags = GuidelineTag.order(:name)
    guidelines = {}

    Guideline.all.each do |g|
      tag_name = g.guideline_tag_id.nil? ? "Other" : g.guideline_tag.name
      guidelines[tag_name] ||= []
      guidelines[tag_name] << g
    end

    guidelines.each do |k,v|
      puts k, v.size
    end

    guidelines
  end

  def enumerated_legal_documents(this_company)
    docs = this_company.legal_documents

    docs.collect do |g|
      [g.name, g.id]
    end
  end

  def enumerated_implementations
    Practice.implementations.collect.with_index do |name, index|
      [name, index]
    end
  end

end
