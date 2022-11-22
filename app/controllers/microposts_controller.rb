# frozen_string_literal: true

class MicropostsController < ApplicationController
  include SessionsHelper

  before_action :correct_user, only: :destroy

  def new
    @micropost = Micropost.new
  end

  def show
    @micro = Micropost.find(params[:id])
    
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
