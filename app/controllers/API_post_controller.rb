class APIPostsController
  def index
    render App..to_json, status: "200 OK"
  end

  def show
    post = find_post_by_id

    if post
      render post.to_json
    else
      render_not_found
    end
  end

  def create
    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  def update
    render post.to_json, status: "200 OK"
  end

  def destroy
    post = find_post_by_id
  end

  private

  def find_post_by_id
    App.posts.find { |u| u.id == params[:id].to_i }
  end
  
end
