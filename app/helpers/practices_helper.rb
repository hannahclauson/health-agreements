module PracticesHelper

  def enumerated_guidelines
    guidelines = Guideline.all
    guidelines.collect do |g|
      [g.name, g.id]
    end
  end

  def enumerated_implementations
    Practice::IMPLEMENTATION_MAP.collect do |int_value, name|
      [name, int_value]
    end
  end

end
