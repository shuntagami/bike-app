window.addEventListener('load', function(){
  const posts = document.querySelectorAll(".cards");
  posts.forEach(function (post) {
    post.addEventListener('mouseover', function(){
      post.style.backgroundColor = '#F2F2F2'; 
    });
    post.addEventListener('mouseout', function(){
      post.style.backgroundColor = '';
    })
  })
})

// jQueryで書いたとき
// $(function() {
//   $('.cards').each(function(index, element) {
//     $(element).hover(
//       function(){
//         $(element).css('backgroundColor', '#F2F2F2');            
//       },
//       function(){
//         $(element).css('backgroundColor', '');
//       });
//   })
// });
