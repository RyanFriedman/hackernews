require 'will_paginate/array' 
require "uri"
class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :destroy]
  
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
    @title = "Show Projection Room"
    @description = "Show PR is for sharing your work. Please read the guidelines. The newest Show PRs are here."
    render :template => "posts/index.html"
  end
  
  def submit
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = Comment.popular.where(:post_id => @post.id, :parent_id => nil)
  end
  
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
       format.html {  redirect_to @post }
       format.js {}
      else 
       format.html { render action: "submit", status: :unprocessable_entity }        
      end
    end
  end
  
  def destroy
    @post
    @post.destroy if current_user.admin?
    current_user.posts.find(@post).destroy
    redirect_to :index
  end
  
  private
  
    def set_post
      @post = Post.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :url)
    end
    
end