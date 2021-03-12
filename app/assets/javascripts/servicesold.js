var init_service_lookup;

init_service_lookup = function() {
  $('#service-lookup-form').on('ajax:success', function(event, data, status) {
    $('#service-lookup').replaceWith(data);
    init_service_lookup();
  })
}

$(document).ready(function() {
  init_service_lookup();
})