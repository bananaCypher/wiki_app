class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    comment = Comment.create(comment_params)
    comment.update(user_id: current_user.id)
    redirect_to article_path(params['comment']['article_id'])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to article_path(comment.article)
  end

  def destroy
    comment = Comment.find(params[:id])
    article_id = comment.article_id
    comment.destroy
    redirect_to article_path(article_id)
  end
  private
  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end