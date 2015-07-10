module SlimValidation
end

require 'slim'

class SlimValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    result = Slim::Template.new(options[:options]) { value }.render(options[:scope] == :record ? record : options[:scope])
  rescue
    record.errors.add(attr_name, :invalid_slim, options)
  ensure
    if (to = options[:to]).present?
      to.is_a?(Proc) ? to.(record, result) : record[to] = result
    end
  end
end