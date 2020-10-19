import consumer from "./consumer"

consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const html = 
    `<div class="p-comment__item">
      ${data.comment.text}
      <div class="p-comment__bottomLine">
        <a href = "/users/${data.comment.user_id}"><img src="/assets/no-avatar.png" alt="avatar image" class="user_avatar"></a>
        <span> <a href = "/users/${data.comment.user_id}">${data.user.name}</a> </span>
        <span>${data.time}</span>
        <span> <a data-confirm="コメントを削除してもよろしいですか？" rel="nofollow" data-method="delete" href="/posts/${data.comment.post_id}/comments/${data.comment.id}">削除</a> </span>
      </div>
     </div>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});




