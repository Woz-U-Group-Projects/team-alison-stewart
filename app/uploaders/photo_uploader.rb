class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Constants
  CONFIG = Rails.application.secrets

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  if Rails.env.test?
    def base_path
      "#{File.expand_path(CONFIG.fog_local_root)}/#{CONFIG.fog_directory}/"
    end
  else
    def base_path
      ''
    end
  end

  version :thumbnail do
    process resize_to_fit: [350, 350]
  end
end
