class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
       flash[:notice] = "Pin was successfully updated!"
      redirect_to @pin
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      flash[:notice] = "Successfully created new Pin"
      redirect_to @pin
    else
      render 'new'
    end
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end

  private

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def pin_params
    params.require(:pin).permit(:title, :description, :image, :image_file_name)
  end
end
