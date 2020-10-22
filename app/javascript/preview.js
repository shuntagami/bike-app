document.addEventListener('DOMContentLoaded', function(){
  const fileField = document.getElementById("post_image");
  fileField.addEventListener('change', function(e) {
    const file = e.target.files[0];
    const reader = new FileReader();
    $preview = $("#img_field")
    // const preview = document.getElementById('img_field');  
    // var nest   = document.querySelector('image_tag');
    reader.readAsDataURL(file)
    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        // preview.removeChild(nest);
        $preview.append($('<img>').attr({
          src: e.target.result,
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});