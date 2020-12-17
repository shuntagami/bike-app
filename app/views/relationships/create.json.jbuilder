json.followers_count @user.followers.length
json.following_count current_user.following.length
json.current_user_in_followers @user.followers.include?(current_user)
