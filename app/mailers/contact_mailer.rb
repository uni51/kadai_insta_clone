class ContactMailer < ApplicationMailer
  # 以下はローカル環境確認用
  def contact_mail(user, blog)
   @user = user
   @blog = blog

   mail to: @user.email, subject: "ブログ作成完了メール"
  end
end
