class AddProgramSlugToLookBooks < ActiveRecord::Migration
  def change
    add_column :look_books, :program_slug, :string
  end
end
