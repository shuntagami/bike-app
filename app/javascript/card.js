if (!document.URL.match( /posts/ )) {  
  document.addEventListener('DOMContentLoaded', () => {
    const posts = document.querySelectorAll(".card");
    posts.forEach(function (post) {
      post.addEventListener('mouseover', () => {
        post.style.backgroundColor = '#F2F2F2'; 
      });
      post.addEventListener('mouseout', () => {
        post.style.backgroundColor = '';
      });
    });
  });
}