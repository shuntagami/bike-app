document.addEventListener('DOMContentLoaded', () => {
  const flashMessage = document.querySelector('.alert');
  
  const fadeOutFlashMessage = () => {
    // setIntervalを特定するために返り値を変数timer_idに格納
    const timer_id = setInterval(() => {
      // flashメッセージのstyle属性 opacityを取得
      const opacity = flashMessage.style.opacity;
      if (opacity > 0) {
        flashMessage.style.opacity = opacity - 0.1;
      } else {
        flashMessage.style.display = 'none';
        // setIntervalをストップさせる
        clearInterval(timer_id);
      };
    }, 50);
  }

  if (flashMessage !== null) {
    // style属性opacityをセット
    flashMessage.style.opacity = 1;
    // 表示から5秒後に上記で定義したフェードアウトさせる関数を実行
    setTimeout(fadeOutFlashMessage, 5000);
  };
});