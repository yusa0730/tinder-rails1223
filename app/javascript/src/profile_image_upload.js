$(document).on("change", "#profile_image_upload", function(e) {
  // このコードで、ファイルの有無を判定しています。
  if (e.target.files.length) {
    let reader = new FileReader;
    // reader.onload = function(e) { で reader(ファイル)が読み込まれたとき、function(e)以下を実行します。
    reader.onload = function(e) {
      $('.hidden').removeClass();
      $('.profile-default-img').removeClass();
      $('#profile-img').remove();
      $('#profile-img-prev').attr('src', e.target.result);
    };
    // readAsDataURLメソッドは、指定されたファイルの読み込みを実行します。
    return reader.readAsDataURL(e.target.files[0]);
  }
});