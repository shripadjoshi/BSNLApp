
$(document).on('turbolinks:load', function(){
  ///All the datatables
  $('#sims').DataTable();
  $('#roles').DataTable();
  $('#users').DataTable();
  $('.sim-datepicker').datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayHighlight: true,
    endDate: '+0d'
  });

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

  $(".sim_type").on("change", function(){
    $(".sim_pairedness").prop('disabled', false);
    if ($(this).val() === 'Postpaid') {
      $(".sim_pairedness option[value*='Paired']").prop('disabled',true);
      $(".sim_category option[value*='DSA SIM']").prop('disabled',true);
      $(".sim_category option[value*='International roaming SIM']").prop('disabled',false);
    } else {
      $(".sim_pairedness option[value*='Paired']").prop('disabled',false);
      $(".sim_category option[value*='DSA SIM']").prop('disabled',false);
      $(".sim_category option[value*='International roaming SIM']").prop('disabled',true);
    }
  });

  $(".sim_pairedness").on("change", function(){
    $(".sim_category").prop('disabled', false);
    if ($(this).val() === 'Paired') {
      $(".sim_category option").prop('disabled',true);
    } else if($(this).val() === 'Unpaired' && $(".sim_type").val() === 'Prepaid') {
      $(".sim_category option[value*='DSA SIM']").prop('disabled',false);
      $(".sim_category option[value*='Normal SIM']").prop('disabled',false);
      $(".sim_category option[value*='International roaming SIM']").prop('disabled',true);
    } else {
      $(".sim_category option[value*='DSA SIM']").prop('disabled',true);
      $(".sim_category option[value*='Normal SIM']").prop('disabled',false);
      $(".sim_category option[value*='International roaming SIM']").prop('disabled',false);
    }
  });
});

function dailyChart(prepaid, postpaid, saleDate) {
  var myChart = Highcharts.chart('daily_sale', {
    chart: {
        type: 'bar'
    },
    title: {
        text: 'Daily sale'
    },
    xAxis: {
      categories: ['Prepaid', 'Postpaid'],
      allowDecimals: false
  },
    yAxis: {
        title: {
            text: 'Daily sale'
        },
        allowDecimals: false
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
          '<td style="padding:0"><b>{point.y}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
  },
    series: [{
      name: saleDate,
      data: [parseInt(prepaid), parseInt(postpaid)]
  }]
  });
}

function weeklyChart(saleDates, prepaid, postpaid) {
  var myChart = Highcharts.chart('weekly_sale', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Weekly sale'
    },
    xAxis: {
        categories: JSON.parse(saleDates),
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Weekly sale'
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y}</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [{
        name: 'Prepaid',
        data: JSON.parse(prepaid)

    }, {
        name: 'Postpaid',
        data: JSON.parse(postpaid)

    }]
}); 
}