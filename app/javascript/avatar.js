if (document.URL.match( /users\/(\d+)\/edit/ )) {
  document.addEventListener('DOMContentLoaded', () => {
    var fileField = document.getElementById("user_avatar");
    fileField.addEventListener('change', (e) => {
      var preview = document.getElementById('avatar_field');
      var file = e.target.files[0];
      var reader = new FileReader();  
      reader.readAsDataURL(file)

      // 読み込み成功後即時に実行されるイベント
      reader.onload = ((file) => {
        return (e) => {
          // すでに存在している画像を消去
          preview.innerHTML = null;

          // imgタグを作成し、属性を追加
          var img = document.createElement('img');
          img.className = 'preview';
          img.src = e.target.result;
          console.log(e.target.result);

          // 新しいimg要素を追加
          preview.appendChild(img);
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
}


