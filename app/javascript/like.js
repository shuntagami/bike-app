if (document.URL.match( /posts\/(\d+)/ )) {  
  function like() {
    const buttons = document.querySelectorAll("a[data-remote]");
    buttons.forEach((button) => {
      // ajax通信に成功したときの処理
      button.addEventListener('ajax:success', (e) => {
        const receivedData = e.detail[0];
        const likesCountArea = document.getElementById(`likes_area_${receivedData.post_id}`)
        // like => liked
        if (receivedData.like) {
          insertHTML = prepareHTML(receivedData, "plus");
        }
        // liked => like
        else {
          insertHTML = prepareHTML(receivedData, "minus");
        }
        button.innerHTML = null;
        button.insertAdjacentHTML('afterbegin', insertHTML);
        likesCountArea.innerHTML = null;
        likesCountArea.insertAdjacentHTML('afterbegin', `いいね${receivedData.count} 件`);
      });
    
      // ajax通信に失敗したときの処理
      button.addEventListener('ajax:error', (e) => {
        const errorMessage = e.detail[1]; 
        alert(errorMessage);
      });
    });
  };
  document.addEventListener("DOMContentLoaded", like);
  
  
  // クリックごとに入れ替わるボタンのhtmlを生成
  prepareHTML = (receivedData, plus_or_minus) => {
    const likes_count = receivedData.count;
    const likedButton = `<i class="fa-heart fas fa-lg" aria-hidden="true"></i>
                         <span>${likes_count}</span>`;
  
    const likeButton = `<i class="fa-heart far fa-lg" aria-hidden="true"></i>
                        <span>${likes_count}</span>`;
    
    if (plus_or_minus === "plus") {
      return likedButton;
    } 
    else if (plus_or_minus === "minus") {
      return likeButton;
    }
  };
}











