require 'will_paginate/array' 
require "uri"
class PostsController < ApplicationController
  def index
    @posts = Post.popular.paginate(:page => params[:page], :per_page => 30)
  end
  
  def newest
    @posts = Post.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    @title = "Newest Submissions"
    render :template => "posts/index.html"
  end
  
  def ask
    @posts = Post.where(:post_type => "ask").order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    @title = "Ask PR"
    render :template => "posts/index.html"
  end
  
  def showoff
    @posts = Post.where(:post_type => "show").order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    @title = "Show PR"
    render :template => "posts/index.html"
  end
  
  def submit
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      redirect_to @post
    else 
      render :submit
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :url)
    end
    
end