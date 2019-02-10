$(function() {

  onload();
  document.addEventListener("page:load", onload);

});

function onload() {
  $('.submitable').unbind('change');

  $('.submitable').on('change', function(){
    $(this).closest('form').submit();
  });

  $('.display-classify-form').on('click', function(){
    var id = $(this).data('id');
    $("#validate_tweet_" + id).addClass('hidden');
    $("#wrong_validate_tweet_" + id).removeClass('hidden');
  });

  $('.display-stats-on-hover').mouseover(function() {
    $('*[class^="div-on-hover"]').css("display", "none");
    $('*[id^="category-home-item"]').addClass("brightness-category-item");
    $('.div-on-hover-' + this.id).css("display", "block");
    $('#category-home-item-' + this.id).removeClass("brightness-category-item");
  });

  $(window).scroll(function(){
    var fromTop = $(window).scrollTop();
    if (fromTop < 75) {
      $(".landing-stats").css('margin', '-' + fromTop + 'px 0px 0px 0px');
    }
  });
}
