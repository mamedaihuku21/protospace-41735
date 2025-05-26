class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  #excpect 指定したものは誰でも見れる（指定したもの以外を制限）
  #only 指定したものはログインしてないと見れない（指定したものを制限）
  before_action :set_prototype, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
      @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path  
    else
      render :new  
    end             #ifの終わりのend
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])  #表示を変更させるプロトタイプを取得
    if @prototype.update(prototype_params)  #更新成功したのかどうか
      redirect_to prototype_path(@prototype)  #成功していたら詳細ページへ
    else
      render :edit  #失敗したら再表示
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])  #削除したいプロトタイプを取得
    @prototype.destroy  #上の行で取得したのを削除する
    redirect_to root_path  #削除が終わったらトップページに戻る
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless @prototype.user == current_user
  end
end

