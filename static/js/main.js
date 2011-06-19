$(function() {
      $(".notification").each(function(i,v) {
                                  if (i % 2 != 0) {
                                      $(this).addClass("odd");
                                  }
      });
});
