if (document.URL.match( /users\/(\d+)\/edit/ )) {
  document.addEventListener('DOMContentLoaded', () => {
    const ImageList = document.getElementById('avatar_field');

    const createImageHTML = (blob) => {
       // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');

      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.width = 250;
      blobImage.height = 250;

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };

    document.getElementById('user_avatar').addEventListener('change', (e) => {
      // すでに存在している画像を削除
      ImageList.innerHTML = null;

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}