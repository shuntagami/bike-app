if (document.URL.match( /posts\/new/ ) || document.URL.match( /posts\/(\d+)\/edit/ )) {
  document.addEventListener('DOMContentLoaded', () => {
    const fileField = document.getElementById("post_image");
    fileField.addEventListener('change', (e) => {
      const preview = document.getElementById('img_field');
      const file = e.target.files[0];
      const reader = new FileReader();  
      reader.readAsDataURL(file)

      // 読み込み成功後即時に実行されるイベント
      reader.onload = ((file) => {
        return (e) => {
          // すでに存在している画像を消去
          preview.innerHTML = null;

          // imgタグを作成し、属性を追加
          const img = document.createElement('img');
          img.className = 'preview';
          img.src = e.target.result;

          // 新しいimg要素を追加
          preview.appendChild(img);
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
}