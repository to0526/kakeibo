$(function() {
  $('#check_all_year_months').on('click', function() {
    $("input[name='search[year_months][]']").prop('checked', this.checked);
  });
  $('#check_all_users').on('click', function() {
    $("input[name='search[user_ids][]']").prop('checked', this.checked);
  });
  $('#check_all_payment_methods').on('click', function() {
    $("input[name='search[payment_method_ids][]']").prop('checked', this.checked);
  });
  $('#check_all_payment_classifications').on('click', function() {
    $("input[name='search[payment_classification_ids][]']").prop('checked', this.checked);
  });
});
