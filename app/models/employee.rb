class Employee < ActiveRecord::Base
  # Gem definitions
  acts_as_list

  # Instance methods
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
