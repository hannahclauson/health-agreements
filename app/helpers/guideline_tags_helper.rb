module GuidelineTagsHelper

  def enumerated_guideline_tags
    guideline_tags = GuidelineTag.all
    puts guideline_tags.inspect
    guideline_tags.collect do |g|
      [g.name, g.id]
    end
  end

end
