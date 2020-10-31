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
        likesCountArea.insertAdjacentHTML('afterbegin', `いいね${receivedData.count}件`);
      });
    
      // ajax通信に失敗したときの処理
      button.addEventListener('ajax:error', (e) => {
        alert(e.detail[1]);
      });
    });
  };
  document.addEventListener("DOMContentLoaded", like);
  
  
  // クリックごとに入れ替わるボタンのhtmlを生成
  prepareHTML = (receivedData, plus_or_minus) => {
    var button_class = "";
    const likes_count = receivedData.count;
    if (plus_or_minus == "plus") {
      button_class += "fa-heart fas fa-lg";
    } 
    else if (plus_or_minus == "minus") {
      button_class += "fa-heart far fa-lg";
    }
    const html = `<i class="${button_class}" aria-hidden="true"></i>
                  <span>${likes_count}</span>`;
    return html;
  };
}











