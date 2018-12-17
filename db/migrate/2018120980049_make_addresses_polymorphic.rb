class MakeAddressesPolymorphic < ActiveRecord::Migration
  def up
    add_column :addresses, :owner_type, :string
    add_column :addresses, :owner_id,   :integer

    Address.connection.schema_cache.clear!
    Address.reset_column_information

    Booking.all.each do |booking|
      next unless booking.address_id

      address = Address.find(booking.address_id)

      address.owner_type = 'Booking'
      address.owner_id = booking.id

      address.save
    end

    Registration.all.each do |registration|
      next unless registration.address_id

      address = Address.find(registration.address_id)

      address.owner_type = 'Registration'
      address.owner_id = registration.id

      address.save
    end

    School.all.each do |school|
      next unless school.address_id

      address = Address.find(school.address_id)

      address.owner_type = 'School'
      address.owner_id = school.id

      address.save
    end

    Address.where('owner_type IS NULL').destroy_all

    change_column :addresses, :owner_type,  :string,  null: false
    change_column :addresses, :owner_id,    :integer, null: false

    remove_column :bookings,       :address_id
    remove_column :registrations,  :address_id
    remove_column :schools,        :address_id
  end

  def down
    add_column :bookings,       :address_id, :integer
    add_column :registrations,  :address_id, :integer
    add_column :schools,        :address_id, :integer

    Booking.connection.schema_cache.clear!
    Booking.reset_column_information

    Registration.connection.schema_cache.clear!
    Registration.reset_column_information

    School.connection.schema_cache.clear!
    School.reset_column_information

    Address.all.each do |address|
      next unless address.owner

      address.owner.address_id = address.id
      address.owner.save
    end

    remove_column :addresses, :owner_type
    remove_column :addresses, :owner_id
  end
end
