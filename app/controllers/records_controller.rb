class RecordsController < ApplicationController
  before_action :authenticate_user 
  before_action :set_record, only: [:show, :edit, :update, :destroy] 
  before_action :set_room 
  before_action :set_user 

  def add_room
    # Drop course and redirect to @user
    # Check if 
    # 1) @user is a student
    # 2) @user is NOT registered to the @course
    
    if @user == current_user 
      @room.users << @user unless @user.is_faculty || @room.students.include?(@user)
    end
    redirect_to @user
  end


  def drop_room
    # Drop course and redirect to @user
    # Check if 
    # 1) @user is a student
    # 2) @user is registered to the @course
    if @user == current_user 
      @room.users.delete(@user) unless @user.is_faculty
    end
    redirect_to @user
  end


  private
  
  def set_room
    # Find the course using `course_id`
    @room = Room.find(params[:room_id])
  end

  def set_user
    # Find the user using `course_id`
    @user = User.find(params[:user_id])
  end
end
