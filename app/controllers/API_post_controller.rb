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
end
