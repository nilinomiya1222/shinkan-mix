ready = ->
  $('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

$(document).ready(ready)
$(document).on('page:load', ready)