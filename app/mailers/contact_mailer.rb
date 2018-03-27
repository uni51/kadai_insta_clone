class ContactMailer < ApplicationMailer
  # 以下はローカル環境確認用
  def contact_mail(user, picture)
   @user = user
   @picture = picture

   mail to: @user.email, subject: "投稿完了メール"
  end
end
