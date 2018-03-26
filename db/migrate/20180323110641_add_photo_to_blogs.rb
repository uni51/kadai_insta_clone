class AddPhotoToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :photo, :string
  end
end
