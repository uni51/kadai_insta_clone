class BlogsController < ApplicationController # < で継承している
  before_action :require_user_logged_in, only: [:new, :edit, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def top
  end

  def index
    @blogs = Blog.all
    #binding.pry # pry-railsでブレークポイントを設定して、デバッグ
    #raise # better_errorsでエラー画面を出力させる
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new  #ビューにデータを渡す(インスタンス変数を定義する)
    end
  end

  def create
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    # 下記の1行は、上記の2行をまとめて記述している
    @blog = current_user.blogs.build(blog_params)
    # binding.pry
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      flash[:success] = 'ブログを作成しました！'
      redirect_to blogs_path
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def show
    # @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      flash[:success] = 'ブログを編集しました！'
      redirect_to blogs_path
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    flash[:success] = 'ブログを削除しました！'
    redirect_to blogs_path
  end

  def confirm
    @blog = Blog.new(blog_params)
    # render :new if @blog.invalid?
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  # idをキーとして値を取得するメソッド
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
