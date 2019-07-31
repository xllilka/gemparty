class CommentsController < ApplicationController
    before_action : :authenticate_user!

    def create
        
    end

    def destroy
        comment = Comment.find params[:id]
        comment.destroy

        redirect_back(fallback_location: root_path)
    end

    private
    def load_post
        @post = Post.find params[:post_id]
    end

    def comment_params
        params[:comment][:user_id] = current_user.id
        params.require(:comment).permit(:user_id,:body)
    end

end
