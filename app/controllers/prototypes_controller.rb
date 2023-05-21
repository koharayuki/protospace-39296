class PrototypesController < ApplicationController
  before_action :move_to_index, only: :edit

  def index
    @users = User.all
    @prototypes = Prototype.all

  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def edit
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to prototypes_index_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

    private
    def user_name
    params.require(:user).permit(:name).merge(user_id: current_user.id)
    end

    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image,).merge(user_id: current_user.id)
    end
end
