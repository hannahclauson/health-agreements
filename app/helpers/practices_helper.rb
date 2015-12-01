module PracticesHelper

  # Seems like it should be in guidelines helper, but it belongs here
  # - This is used only when creating/editing a practice, as only the avail
  # guidelines are valid options
  def enumerated_guidelines
#    guidelines = Guideline.all

#    guidelines = Guideline.order("guideline_tag_id")
    tags = GuidelineTag.all
    guidelines = Guideline.order(guideline_tag_id: tags)


    last_tag = nil

    entries = []

    guidelines.each do |g|
      this_tag_name = g.guideline_tag.nil? ? nil : g.guideline_tag.name

      if this_tag_name != last_tag
        if this_tag_name.nil?
          entries << ["Other", nil]
        else
          entries << [this_tag_name, nil]
        end
      end

      last_tag = this_tag_name

      entries << ["- #{g.name}", g.id]
    end

    entries
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
