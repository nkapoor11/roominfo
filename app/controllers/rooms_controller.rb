class RoomsController < ApplicationController
  before_action :authenticate_user
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_authorization, only: [:edit, :update, :destroy]
  before_action :check_new_authorization, only: [:new, :create]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        @room.users << current_user
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authenticate_user
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:location, :number, :room_type, :description)
    end

    def check_edit_authorization
      redirect_to "/rooms" unless current_user.is_faculty && @room.faculty.id == current_user.id
    end
  
    def check_new_authorization
      redirect_to "/rooms" unless current_user.is_faculty
    end
 
end
