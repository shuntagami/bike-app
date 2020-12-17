json.post_id @post.id
json.count @post.likes.count
json.like @post.liked_by?(current_user)
