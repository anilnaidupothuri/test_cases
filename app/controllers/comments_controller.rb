# frozen_string_literal: true

class CommentsController < ApplicationController

  def show 
    @comment = Comment.find(params[:id])
  end
  def new
    @micro = Micropost.find(params[:micropost_id])
    @comment = Comment.new
  end

  def create
    @micro = Micropost.find(params[:micropost_id])

    @comment = current_user.comments.new(comments: params[:comment][:comments], micropost: @micro)

    if @comment.save
      redirect_to current_user
    else
      flash[:danger] = 'something wrong'
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to micropost_path
   end
end
