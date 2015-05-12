Spree::Address.class_eval do
  belongs_to :user, :class_name => Spree.user_class.to_s
  acts_as_paranoid

  def self.required_fields
    Spree::Address.validators.map do |v|
      v.kind_of?(ActiveModel::Validations::PresenceValidator) ? v.attributes : []
    end.flatten
  end

  def same_as?(other)
    return false if other.nil?
    attributes.except('id', 'updated_at', 'created_at', 'alternative_phone') == other.attributes.except('id', 'updated_at', 'created_at', 'alternative_phone')
  end

  # can modify an address if it's not been used in an completed order
  def editable?
    new_record? || !Spree::Order.complete.where("bill_address_id = ? OR ship_address_id = ?", self.id, self.id).exists?
  end

  def to_s
    [
      "#{firstname} #{lastname}",
      "#{company}",
      "#{address1}",
      "#{address2}",
      "#{city} #{state_text} #{zipcode}",
      "#{country}"
    ].reject(&:empty?).join(" <br/>").html_safe
  end

end
