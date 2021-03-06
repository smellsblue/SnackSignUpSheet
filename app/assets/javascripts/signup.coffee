$.signupDayClick = (day) ->
    check = window.checkMap[day.format("YYYY-MM-DD")]
    return if !check || !check.available
    modal = $ "#signup"
    modal.find("input[name='day']").val(day.format("YYYY-MM-DD"))
    modal.find(".friendly-day").text(day.format("dddd, MMMM Do, YYYY"))
    modal.modal("show")

$.adminDayClick = (day) ->
    check = window.checkMap[day.format("YYYY-MM-DD")]

    if check
        modal = $ "#edit-date"
        existing_name = check.name || ""
    else
        modal = $ "#add-date"
        existing_name = ""

    modal.find("input[name='day']").val(day.format("YYYY-MM-DD"))
    modal.find("input[name='existing_name']").val(existing_name)
    modal.find(".friendly-day").text(day.format("dddd, MMMM Do, YYYY"))
    modal.modal("show")

eventClick = (event) ->
    if window.dayClick
        window.dayClick(event.start)

$(document).on "shown.bs.modal", ->
    $(@).find(".to-focus").focus()

$ ->
    $("#calendar").fullCalendar
        dayClick: window.dayClick
        eventClick: eventClick
        eventSources: window.eventSources
        validRange:
            start: window.minDate
            end: window.maxDate
