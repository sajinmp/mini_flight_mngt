$(document).on('turbolinks:load', function() {
  $('input[name=seat]').click(function() {
    var seat_detail_json = JSON.parse($('#seat_nos').val());
    var info = $('.booking-list');
    var no_of_seats = $('#booking_no_of_seats').val();
    var connected = info.data('connected') || false;
    // var selected_seats = $('input[name=seat]:checked').length;
    var amount = parseFloat($('#booking_amount').val()) || 0;
    var seat_type = $(this).data('seat_type');
    var flight_id = $(this).data('flight_id');
    var seat_no = $(this).val();
    var amt = parseFloat($(this).data('amount'));
    if($(this).is(':checked')) {
      seat_detail_json[flight_id] = seat_detail_json[flight_id] || [];
      seat_detail_json[flight_id].push({'seat_no': seat_no, 'seat_config': seat_type});
      amount = amount + amt;
      $('#booking_amount').val(amount);
      if (seat_detail_json[flight_id].length >= no_of_seats) {
        $('input[data-flight_id=' + flight_id + ']').attr('disabled', true);
        $('input[data-flight_id=' + flight_id + ']:checked').attr('disabled', false);
      }
    } else {
      seat_detail_json[flight_id].splice($.inArray({seat_no: seat_type}, seat_detail_json[flight_id]), 1);
      amount = amount - amt;
      $('#booking_amount').val(amount);
      if (seat_detail_json[flight_id].length < no_of_seats) {
        $('input[data-flight_id=' + flight_id + ']').attr('disabled', false);
        $('input[data-seat_booked=true]').attr('disabled', true);
      }
    }
    $('#amount').html(amount);
    $('#seat_nos').val(JSON.stringify(seat_detail_json));

    // if ($('input[name=seat]:checked').length != 0) {
    //   $('input[data-seat_type=' + seat_type + ']').attr('disabled', true);
    //   $(this).attr('disabled', false);
    //   var seat_no = $(this).val();
    //   var amt = parseFloat($(this).data('amount')) - old_amount;
    //   $('#booking_seat_no').val(seat_no);
    //   $('#booking_amount').val(amt);
    //   $('#amount').html(amt);
    // } else {
    //   $('input[data-seat_type=' + seat_type + ']').attr('disabled', false);
    //   $('input[data-seat_booked=true]').attr('disabled', true);
    //   $('#booking_seat_no').val('');
    //   $('#booking_amount').val('');
    //   $('#amount').html('');
    // }
  });

  $('#submit_btn').click(function() {
    var purchase_info = {};
    var names = $('input[name=name]');
    $.each(names, function(index, tag) {
      var flight_id = $(tag).data('flight_id');
      var seat_no = $(tag).data('seat_no');
      var seat_config = $(tag).data('seat_config');
      var name = $(tag).val();
      if (name.length < 1) {
        $('.submit-error').text('Please enter valid name');
      }
      purchase_info[flight_id] = purchase_info[flight_id] || [];
      purchase_info[flight_id].push({'seat_no': seat_no, 'name': name, 'seat_config': seat_config});
    });
    $('#passenger_info').val(JSON.stringify(purchase_info));
    $('#passenger_info_form').submit();
  });
});
