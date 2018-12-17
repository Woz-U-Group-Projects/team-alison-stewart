module HasMoney
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # Instance methods
    def has_money(*attributes)
      attributes.each do |attribute|
        class_eval <<-EOS
          def #{attribute}_in_dollars
            self.class.calculate_dollars_from_cents(#{attribute})
          end

          def #{attribute}_in_dollars=(dollars)
            self.#{attribute} = self.class.calculate_cents_from_dollars(dollars)
          end
        EOS
      end
    end

    def calculate_dollars_from_cents(cents)
      return nil if cents.nil? ||  cents == ''
      cents.to_f / 100
    end

    def calculate_cents_from_dollars(dollars)
      return nil if dollars.nil? || dollars == ''
      (dollars.to_f * 100).round
    end
  end
end

# Inlcude in all AR Models
ActiveRecord::Base.send :include, HasMoney
