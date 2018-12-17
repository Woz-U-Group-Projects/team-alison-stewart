class AddGradGroupCodeToDemoVideos < ActiveRecord::Migration
  def change
    add_column :demo_videos, :grad_group_code, :string
  end
end
