class Setting < ActiveRecord::Base
  # Class methods
  def self.method_missing(method_name, *args, &block)
    if method_name.match(/=$/)
      method_name = method_name[0..-2]

      record = find_record(method_name) || Setting.new(key: method_name)
      record.value = args[0].to_yaml
      record.save!
    else
      record = find_record(method_name)
      record ? YAML.load(record.value) : nil
    end
  end

  private

  def self.find_record(method_name)
    self.where(key: method_name).first
  end
end
