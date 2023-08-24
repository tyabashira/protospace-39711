class PrototypesController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :move_to_index, except: [:index, :show]
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
    render :new, status: :unprocessable_entity
  end
end

def show
  @prototype = Prototype.find(params[:id])
  
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user)
end

def edit
  @prototype = Prototype.find(params[:id])
  if @prototype.user != current_user
    redirect_to root_path
    return
  end
end

def update
  @prototype = Prototype.find(params[:id])

  if current_user.id == @prototype.user_id  
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit, status: :unprocessable_entity
    end
  else
    redirect_to root_path
  end
end

def destroy
  @prototype = Prototype.find(params[:id])

  if current_user.id == @prototype.user_id  
    @prototype.destroy
    redirect_to root_path
  else
    redirect_to root_path
  end
end


private
def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
end

def move_to_index
  unless user_signed_in?
    redirect_to action: :index 
  end
end


end
