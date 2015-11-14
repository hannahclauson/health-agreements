module GuidelineTagsHelper

  def enumerated_guideline_tags
    guideline_tags = GuidelineTag.all
    guideline_tags.collect do |g|
      [g.name, g.id]
    end
  end

end
