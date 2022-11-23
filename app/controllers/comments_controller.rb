# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :current_post, only: %i[new create destroy]

  def show
    @comment = Comment.find(params[:micropost_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comments: params[:comment][:comments], micropost: @micro)

    if @comment.save
      redirect_to current_user
    else
      flash[:danger] = 'something wrong'
      render 'new'
    end
  end

  def destroy
    @comment = @micro.comments.find_by(id: params[:id])

    @comment.destroy
    redirect_to @micro
  end

  private

  def current_post
    @micro = Micropost.find(params[:micropost_id])
  end
end
