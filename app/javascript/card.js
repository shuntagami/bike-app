window.addEventListener('load', function(){
  const posts = document.querySelectorAll(".card");
  posts.forEach(function (post) {
    post.addEventListener('mouseover', function(){
      post.style.backgroundColor = '#F2F2F2'; 
    });
    post.addEventListener('mouseout', function(){
      post.style.backgroundColor = '';
    })
  })
})