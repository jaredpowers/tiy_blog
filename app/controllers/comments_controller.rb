class CommentsController < ApplicationController
  def index #GET
    if request[:format] == "json"
      render App.comments.to_json, status: "200 OK"
    else
      @comments = App.comments
      render_template 'comments/index.html.erb'
    end
  end

  def show #GET
    comments = find_comments_by_id

    if comments
      if request[:format] == "json"
        render comments.to_json
      else
        @comments = comments
        render_template 'comments/show.html.erb'
      end
    else
      render_not_found
    end
  end

  # new

  def new
    render_template 'comments/new.html.erb'
  end

  def create #POST
    last_comments = App.comments.max_by { |comments| comments.id }
    new_id = last_comments.id + 1

    App.comments.push(
      comments.new(new_id, params["name"], params["age"])
    )
    puts App.comments.to_json

    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  # edit

  def update #PUT
    comments = find_comments_by_id

    if comments
      unless params["name"].nil? || params["name"].empty?
        comments.name = params["name"]
      end

      unless params["age"].nil? || params["age"].empty?
        comments.age = params["age"]
      end

      # In rails you will need to call save here
      render comments.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy #DELETE
    comments = find_comments_by_id

    if comments
      App.comments.delete(comments) # destroy it 🔥
      render({ message: "Successfully Deleted comments" }.to_json)
    else
      render_not_found
    end
  end

  private

  def find_comments_by_id
    App.comments.find { |u| u.id == params[:id].to_i }
  end

  def render_not_found
    return_message = {
      message: "comments not found!",
      status: '404'
    }.to_json

    render return_message, status: "404 NOT FOUND"
  end
end
