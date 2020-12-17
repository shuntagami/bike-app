json.post_id @post.id
json.count @post.likes.length
json.like @post.liked_by?(current_user)
