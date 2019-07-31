class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #set_post랑 load_post랑 뭐각 다름?  
  before_action :authenticate_user!, only: %i(show new create edit destroy)

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments 
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    # 아래처럼 쓸 수도 있음!
    # @post = current_user.posts.create post_params
    # render :index    

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

    @comment = current_user.comments.create comment_params
    render :index
    # new_comment = Comment.new(content: params[:content],
    #                           post_id: params[:post_id],
    #                           user_id: current_user.id)
    # new_comment.save
    # redirect_to root_path
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end

    @post = current_user.posts.find(params[:id])
    @post.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post][:user_id] = current_user.id
      params.require(:post).permit(:title, :content, :image)
    end

    def comment_params 
      params.require(:comment).permit(:body)
    end
end
