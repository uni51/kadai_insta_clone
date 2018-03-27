class PicturesController < ApplicationController # < で継承している
  before_action :require_user_logged_in, only: [:index, :new, :edit, :show]
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def top
  end

  def index
    @pictures = Picture.all.order(id: "DESC")
    #binding.pry # pry-railsでブレークポイントを設定して、デバッグ
    #raise # better_errorsでエラー画面を出力させる
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
      # 画像保存（create）の際に、キャッシュから画像を復元してから保存する
      @picture.photo.retrieve_from_cache! params[:cache][:photo] if params[:cache][:photo].present?
    else
      @picture = Picture.new  #ビューにデータを渡す(インスタンス変数を定義する)
    end
  end

  def create
    # @picture = Picture.new(picture_params)
    # @picture.user_id = current_user.id
    # 下記の1行は、上記の2行をまとめて記述している
    @picture = current_user.pictures.build(picture_params)

    # 画像保存（create）の際に、キャッシュから画像を復元してから保存する
    @picture.photo.retrieve_from_cache! params[:cache][:photo] if params[:cache][:photo].present?

    # binding.pry
    if @picture.save
      @user = User.find_by(id: current_user.id)
      ContactMailer.contact_mail(@user,@picture).deliver # 追記 メール送信処理
      # 一覧画面へ遷移して"投稿を作成しました！"とメッセージを表示します。
      flash[:success] = '投稿を作成しました！'
      redirect_to pictures_path
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def show
    # @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      flash[:success] = '投稿を編集しました！'
      redirect_to pictures_path
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    flash[:success] = '投稿を削除しました！'
    redirect_to pictures_path
  end

  def confirm
    # render :new if @picture.invalid?
    @picture = Picture.new(picture_params)
    @picture[:user_id] = current_user.id
    render :new if @picture.invalid? # <=バリデーションチェックNGなら戻す
  end

  private
  def picture_params
    params.require(:picture).permit(:content, :photo, :photo_cache)
  end

  # idをキーとして値を取得するメソッド
  def set_picture
    @picture = Picture.find(params[:id])
  end
end
