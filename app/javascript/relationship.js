if (document.URL.match( /users\/(\d+)/ )) {  
  function follow() {
    const buttons = document.querySelectorAll("a[data-remote]");
    buttons.forEach((button) => {
      // ajax通信に成功したときの処理
      button.addEventListener('ajax:success', (e) => {
        const receivedData = e.detail[0];
        const followingCountArea = document.getElementById(`follow_area_${gon.user_id}`)
        const followersCountArea = document.getElementById(`followers_area_${gon.user_id}`)
        // follow => following
        if (receivedData.current_user_in_followers) {
          insertHTML = prepareHtml("plus");
        }
        // following => unfollow
        else {
          insertHTML = prepareHtml("minus");
        }
        button.innerHTML = null;
        button.insertAdjacentHTML('afterbegin', insertHTML);
      
        if (document.URL.match(`users/${gon.current_user_id}`)) {
          followingCountArea.innerHTML = null;
          followingCountArea.insertAdjacentHTML('afterbegin', `${receivedData.following_count}人`);
        }
        else {
          followersCountArea.innerHTML = null;
          followersCountArea.insertAdjacentHTML('afterbegin', `${receivedData.followers_count}人`);
        }
      });
    
      // ajax通信に失敗したときの処理
      button.addEventListener('ajax:error', (e) => {
        alert(e.detail[1]);
      });
    });
  };
  document.addEventListener("DOMContentLoaded", follow);
  
  
  // クリックごとに入れ替わるボタンのhtmlを生成
  prepareHtml = (plus_or_minus) => {
    const FOLLOWING_BUTTON = `<button class="unfollow_button">
                                <span class="nomal">Following</span>
                                <span class="hover">Unfollow</span>
                              </button>`;
  
    const FOLLOW_BUTTON = `<button class="follow_button">Follow</button>`;
  
    if (plus_or_minus === "plus") {
      return FOLLOWING_BUTTON;
    } 
    else if (plus_or_minus === "minus") {
      return FOLLOW_BUTTON;
    }
  };
}