json.followers_count @user.followers.count
json.following_count current_user.following.count
json.current_user_in_followers @user.followers.include?(current_user)
