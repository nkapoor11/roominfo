class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_authorization, only: [:edit, :update, :destroy]
  before_action :check_new_authorization, only: [:new, :create]

  def index
    @comments = Comment.all
  end

  def show
  end

  # GET /comments/new
  def new
    @room = Room.find(params[:room_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end
 
  def create
    @room = Room.find(params[:room_id])
    @comment = @room.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to room_path(@room), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authenticate_user # from hw 3
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to "/rooms", notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:room_id, :content)
    end

    def check_edit_authorization
      redirect_to "/rooms" unless current_user.is_faculty && @room.faculty.id == current_user.id
    end

    def check_new_authorization
      redirect_to "/rooms" unless current_user.is_faculty
    end
end
