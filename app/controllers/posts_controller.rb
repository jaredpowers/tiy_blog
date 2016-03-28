class PostsController < ApplicationController

  def index #GET
      # @posts = App.posts
      render_template 'posts/index.html.erb'
  end

  def show #GET
    post = find_post_by_id

    if
      @post = post
      render_template 'posts/show.html.erb'
    else
      render_not_found
    end
  end

  # new

  def new
    render_template 'posts/new.html.erb'
  end

  def create #POST
    last_post = App.posts.max_by { |post| post.id }
    new_id = last_post.id + 1

    App.posts.push(
      post.new(new_id, params["title"], params["author"], params["body"])
    )
  end

  # edit

  def update #PUT
    post = find_post_by_id

    if post
      unless params["name"].nil? || params["name"].empty?
        post.name = params["name"]
      end

      unless params["age"].nil? || params["age"].empty?
        post.age = params["age"]
      end

      # In rails you will need to call save here
    else
      render_not_found
    end
  end

  def destroy #DELETE
    post = find_post_by_id

    if post
      App.posts.delete(post) # destroy it 🔥
    else
      render_not_found
    end
  end

  private

  def find_post_by_id
    App.posts.find { |u| u.id == params[:id].to_i }
  end

  def render_not_found
    return_message = {
      message: "User not found!",
      status: '404'
    }.to_json

    render return_message, status: "404 NOT FOUND"
  end
end
