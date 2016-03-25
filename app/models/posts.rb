class Post
  attr_accessor :id, :title, :author, :body, :published

  def initialize(id, title, author, body, published)
    @id = id
    @title = title
    @author = author
    @body = body
    @published = published
  end

  def published
    @published == false
  end

  def to_json(_ = nil)
    {
      id: id,
      title: title,
      author: author,
      body: body,
      published: published
    }.to_json
  end
end
