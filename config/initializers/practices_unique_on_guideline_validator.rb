class PracticesUniqueOnGuidelineValidator < ActiveModel::EachValidator
#class PracticesUniqueOnGuidelineValidator < ActiveModel::Validator

  def validate_each(record, attribute, value)
#  def validate(record, attribute, value)
    puts "="*80
    puts "record: #{record.inspect}"
    puts "attribute: #{attribute}"
    puts "value: #{value.inspect}"
    puts "map :#{value.map.inspect}"

#    guidelines = value.company.practices.collect {|p| p.guideline.name }
    guidelines = value.map do |v|
      v.guideline.name
    end
    puts "list of guidelines: #{guidelines}"

    puts "unique guidelines: #{guidelines.uniq.size}"
    puts "value size: #{value.size}"

    unless guidelines.uniq.size == value.size
      puts "ERROR NON UNIQUE PRACTICES"
#    if guidelines.include? value
      record.errors[attribute] << "Practices must be unique on guideline"
      puts "Record errors:"
      puts record.errors.inspect
    end

    record.errors[attribute]
  end

end
