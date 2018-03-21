class ChangeDatatypeUserIdOfBlogs < ActiveRecord::Migration[5.1]
  def change
    # [形式] change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :blogs, :user_id, :integer
  end
end
