require 'net/ftp'

class FtpUploader
  @queue = :high

  CONFIG = Rails.application.secrets
  TEMP_FILE_NAME = 'artona'

  def self.perform(params)
    @file_name  = params['file_name']
    @content    = params['content']
    @booking_id = params['booking_id']

    upload
  end

  def self.upload
    booking = Booking.find(@booking_id)

    raise "Booking #{@booking_id} not found" unless booking.present?

    file = Tempfile.new(TEMP_FILE_NAME)
    file << @content
    file.close

    ftp = Net::FTP.new(CONFIG.ftp_host)
    ftp.passive = true

    ftp.login CONFIG.ftp_user, CONFIG.ftp_password
    ftp.chdir CONFIG.ftp_path if CONFIG.ftp_path.present?
    ftp.puttextfile(file.path, @file_name)

    ftp.close

    booking.uploaded = true
    booking.uploaded_at = Time.now
    booking.save
  end
end
