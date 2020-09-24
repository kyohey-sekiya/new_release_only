class MusicsController < ApplicationController
  before_action :set_music, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index]


  def index
    # @musics = Music.all
    @musics = Music.includes(:user).order("created_at DESC")
    @like = Like.new
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
    url = params[:music][:youtube_url]
    url = url.last(11)
    @music.youtube_url = url
    
    if @music.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @musics = Music.includes(:user).order("created_at DESC")
    @like = Like.new
  end

  def edit
  end

  def update
    if @music.update(music_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    if @music.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private
  def music_params
    params.require(:music).permit(:youtube_url, :title, :artist, :genre_id, :type_id, :year, :month_id, :text, :image, :movie).merge(user_id: current_user.id)
  end

  def set_music
    @music = Music.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end