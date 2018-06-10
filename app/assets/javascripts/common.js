
$(document).ready(function(){
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $(".user_account_active_inactive").on("change", function(){
    //$(".dvLoading").show();
    var clicked_object = $(this);
    $.ajax({
        url: '/users/'+clicked_object.attr("user_id")+'/status',
        type : "PUT",
        success: function(data) {
          alert("User successfully updated.")
          //$(".dvLoading").hide();
        }
    });
  });
});
