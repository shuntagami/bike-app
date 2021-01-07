if (document.URL.match( /posts\/(\d+)/ )) {
  function comment() {
    const submit = document.getElementById("submit");
    submit.addEventListener("click", (e) => {
      fetch(`/posts/${gon.post_id}/comments`, {
        method: "POST",
        body: new FormData(document.getElementById("form")),
      }).then(response => {
        // エラーレスポンスが返されたことを検知する
        if (!response.ok) {
            console.error("エラーレスポンス", response);
        } else {
          return response.json().then(item => {
            const commentList = document.getElementById("comment_list");
            const formText = document.getElementById("comment_text");
            const HTML = escapeHTML`
              <div class="p-comment__item">
                ${item.comment.text}
                <div class="p-comment__bottomLine">
                  <a href = "/users/${item.user.id}"><img src="/assets/no-avatar.png" alt="avatar image" class="user_avatar"></a>
                  <span> <a href = "/users/${item.user.id}">${item.user.name}
                  </a> </span>
                  <span>${item.time}</span>
                  <span> <a data-confirm="コメントを削除してもよろしいですか？" rel="nofollow" data-method="delete" href="/posts/${item.post.id}/comments/${item.comment.id}">削除</a> </span>
                </div>
              </div>
              `;
              // HTMLの挿入
            commentList.innerHTML = "";
            commentList.insertAdjacentHTML("afterend", HTML);
            formText.value = "";
          });
        }
      // HTTP通信に失敗した時（例外処理）
      }).catch(error => {
        console.error(error);
        });
      e.preventDefault();
    });
  }
  document.addEventListener("DOMContentLoaded", comment);
}

function escapeSpecialChars(str) {
  return str
  .replace(/&/g, "&amp;")
  .replace(/</g, "&lt;")
  .replace(/>/g, "&gt;")
  .replace(/"/g, "&quot;")
  .replace(/'/g, "&#039;");
}

function escapeHTML(strings, ...values) {
  return strings.reduce((result, str, i) => {
    const value = values[i - 1];
    if (typeof value === "string") {
        return result + escapeSpecialChars(value) + str;
    } else {
        return result + String(value) + str;
    }
  });  
}
