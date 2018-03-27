class RenameTitleColumnToPictures < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :title, :content
  end
end
