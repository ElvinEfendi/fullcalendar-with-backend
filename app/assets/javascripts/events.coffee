ready = ->
  $eventModal = $('.event-modal')

  $('#calendar').fullCalendar
    defaultView: 'agendaWeek'
    editable: true
    selectable: true
    select: (start, end, jsEvent, view) ->
      $eventModal.modal 'show'

$(document).on 'ready page:load', ready
