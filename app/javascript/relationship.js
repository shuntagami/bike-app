function follow() {
  // const followingCountArea = document.getElementById(`following_${gon.user_id}`)
  // const followersCountArea = document.getElementById(`followers_${gon.user_id}`)
  const buttons = document.querySelectorAll("a[data-remote]");
  buttons.forEach((button) => {
    // ajax通信に成功したときの処理
    button.addEventListener('ajax:success', (e) => {
      // follow => following
      if (e.detail[0].follower_judgment) {
        insertHTML = prepareHtml("plus");
      }
      // following => unfollow
      else {
        insertHTML = prepareHtml("minus");
      }
      button.innerHTML = "";
      button.insertAdjacentHTML('afterbegin', insertHTML);
      // followersCountArea.innerHTML = "";
      // followersCountArea.insertAdjacentHTML('afterbegin', `${e.detail[0].followers_count}人`);
    });

    // ajax通信に失敗したときの処理
    button.addEventListener('ajax:error', (e) => {
      alert(e.detail[1]);
    });
  });
};
document.addEventListener("turbolinks:load", follow);


// クリックごとに入れ替わるボタンのhtmlを生成
prepareHtml = (plus_or_minus) => {
  const FOLLOWING_BUTTON = `<button class="unfollow_button">
                              <span class="nomal">Following</span>
                              <span class="hover">Unfollow</span>
                            </button>`;

  const FOLLOW_BUTTON = `<button class="follow_button">Follow</button>`

  if (plus_or_minus === "plus") {
    return FOLLOWING_BUTTON;
  } else if (plus_or_minus === "minus") {
    return FOLLOW_BUTTON;
  }
};


    // <div class="status-value" id="following_1">
    //         7人
    //       </div>













