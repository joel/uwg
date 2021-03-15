# frozen_string_literal: true

require "pagy/extras/metadata"
require "pagy/extras/array"

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy_array(PostRepository.new.all)

    if stale?(@posts)
      respond_to do |format|
        format.html
        format.json { render json: {data: @posts, pagy: pagy_metadata(@pagy)} }
      end
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    fresh_when @post
  end

  # GET /posts/new
  def new
    @input = PostInput.new
  end

  # GET /posts/1/edit
  def edit
    # @input = PostInput.new(title: post.title, body: post.body)
    post = EditPostAction.new.perform(params[:id]).post
    @input = PostInput.new(
      title: post.title, body: post.body
    )
  end

  # POST /posts or /posts.json
  def create
    @input = PostInput.new(post_params)

    respond_to do |format|
      CreatePostAction.new.perform(@input).and_then do |post|
        format.html { redirect_to post_path(post.id), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: post_path(post.id) }
      end
        .or_else do |errors|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @input = PostInput.new(post_params)

    respond_to do |format|
      UpdatePostAction.new.perform(params[:id], @input)
        .and_then do |post|
        format.html { redirect_to post_path(post.id), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: post_path(post.id) }
      end
        .or_else do |errors|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    DeletePostAction.new.perform(params[:id])

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = ShowPostAction.new.perform(params[:id]).post
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post_input).permit(:title, :body)
  end
end
