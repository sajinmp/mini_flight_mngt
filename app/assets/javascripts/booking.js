$(document).on('turbolinks:load', function() {
  $('input[name=seat]').click(function() {
    var seat_type = $(this).data('seat_type');
    var old_amount = parseFloat($('#old_booking').data('amount')) || 0;
    if ($('input[name=seat]:checked').length != 0) {
      $('input[data-seat_type=' + seat_type + ']').attr('disabled', true);
      $(this).attr('disabled', false);
      var seat_no = $(this).val();
      var amt = parseFloat($(this).data('amount')) - old_amount;
      $('#booking_seat_no').val(seat_no);
      $('#booking_amount').val(amt);
      $('#amount').html(amt);
    } else {
      $('input[data-seat_type=' + seat_type + ']').attr('disabled', false);
      $('input[data-seat_booked=true]').attr('disabled', true);
      $('#booking_seat_no').val('');
      $('#booking_amount').val('');
      $('#amount').html('');
    }
  });
});
