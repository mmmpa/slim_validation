module SlimValidation
end

require 'slim'

class SlimValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    result = Slim::Template.new(options[:options]) { value }.render(options[:scope] == :record ? record : options[:scope])
  rescue => e
    if (error_storer = options[:error]).present?
      record.send("#{error_storer}=", e)
    end
    record.errors.add(attr_name, :invalid_slim, options)
  ensure
    if (to = options[:to]).present?
      to.is_a?(Proc) ? to.(record, result) : record.send("#{to}=", result)
    end
  end
end