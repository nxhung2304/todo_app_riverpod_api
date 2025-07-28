class HexColorValidator < ActiveModel::EachValidator
  HEX_COLOR_REGEX = /\A#[0-9A-Fa-f]{6}\z/.freeze

  def validate_each(record, attribute, value)
    return if value.blank?

    unless HEX_COLOR_REGEX.match?(value)
      record.errors.add attribute, (options[:message] || "must be a valid hex color (e.g., #FF5733)")
    end
  end
end
