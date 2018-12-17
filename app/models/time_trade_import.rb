require 'open-uri'

class TimeTradeImport < ActiveRecord::Base
  # Constancts
  TEMP_FILE_NAME = 'artona-time-trade'

  # Attachments
  mount_uploader :file, CSVUploader

  # Instance methods
  def process
    temp_file = Tempfile.new(TEMP_FILE_NAME)

    temp_file.binmode
    temp_file << open(file_url).read
    temp_file.close

  rescue Errno::ENOENT => e
    Rails.logger.error('Could not find Time Trade import file')
  ensure
    Resque.enqueue(TimeTradeImporter, {
      time_trade_import_id: id,
      file_path: temp_file.path
    })
  end
end
