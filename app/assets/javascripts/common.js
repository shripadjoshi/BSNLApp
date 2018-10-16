
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

function dailyChart(prepaid, postpaid, saleDate, prepaidSale, postPaid) {
  var myChart = Highcharts.chart('daily_sale', {
    chart: {
        type: 'bar'
    },
    plotOptions: {
      series: {
          cursor: 'pointer',
          point: {
              events: {
                  click: function () {
                      generateDrillDownModal(this, prepaidSale, postPaid);
                  }
              }
          }
      }
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

function monthlyChart(saleDates, prepaid, postpaid) {
  var myChart = Highcharts.chart('monthly_sale', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Monthly sale'
    },
    xAxis: {
        categories: JSON.parse(saleDates),
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Monthly sale'
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

function quarterlyChart(quarters, prepaid, postpaid) {
  var myChart = Highcharts.chart('quarterly_sale', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Quarterly sale'
    },
    xAxis: {
        categories: JSON.parse(quarters),
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Quarterly sale'
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

function generateDrillDownModal(dailyContext, prepaidSale, postpaidSale) {
  var sale;
  if(dailyContext.category === 'Prepaid') {
    sale = JSON.parse(prepaidSale);
  } else {
    sale = JSON.parse(postpaidSale);
  }
  $('#myModal .modal-title').html("Daily Sales Drilldown for "+dailyContext.category);
  $('#myModal .modal-body #demo').empty();
  $('#myModal .modal-body #demo').append(
    '<table cellpadding="0" cellspacing="0" border="0" class="display" id="drilldown_daily_sale_modal" width="100%">' +
    '<thead>' +
    '<tr>' +
    '<th>Sim No</th>' +
    '<th>Pairedness</th>' +
    '<th>Category</th>' +
    '<th>Sell Date</th>' +
    '</tr>' +
    '</thead>' +
    '<tbody id="tbody_drilldown_daily_sale_modal">' +
    '</tbody>' +
    '</table>'
    );
  generateTableData(sale);
  $("[rel=tooltip]").tooltip();
  $('#drilldown_daily_sale_modal').dataTable({
    "bFilter": true,
    "bInfo": true,
    "bAutoWidth": false,
    "bLengthChange": false,
    "bProcessing": true,
    "aaSorting": [[ 1, "asc" ]],
    "aoColumnDefs": [
      {
          'bSortable': false,
          'aTargets': [ 0,1,2,3 ]
      }
    ],
    "sDom": '<"top"f>rt<"bottom"ip><"clear">'
});
  $('#myModal').modal('show');
}

function generateTableData(sale) {
  sale.forEach(function(sim) {
    var sim_cat = (sim.sim_category ? sim.sim_category : 'NA');
    $("#tbody_drilldown_daily_sale_modal").append(
        '<tr class="odd gradeX bootstrap">' +
        '<td>' + sim.sim_no + '</td>' +
        '<td>' + sim.sim_pairedness + '</td>' +
        '<td>' + sim_cat + '</td>' +
        '<td>' + sim.sell_date + '</td>' +
        '</tr>');
      
  });
}