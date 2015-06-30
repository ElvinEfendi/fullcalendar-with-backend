showEventForm = (event) ->
  $eventForm = $('.event-modal form')
  $eventForm.find('.starts-at').val event.starts_at
  $eventForm.find('.ends-at').val event.ends_at
  $('.event-modal').modal 'show'

ready = ->
  $('#calendar').fullCalendar
    defaultView: 'agendaWeek'
    editable: true
    selectable: true
    events: '/fetch'
    select: (start, end, jsEvent, view) ->
      event =
        starts_at: start
        ends_at: end
      showEventForm event

$(document).on 'ready page:load', ready
