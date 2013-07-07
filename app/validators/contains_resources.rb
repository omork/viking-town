class ContainsResources < ActiveModel::Validator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be a hash' unless value.is_a?(Hash)
  end
end
