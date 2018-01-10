$.adminDayClick = (day) ->
    $("#add-date input[name='day']").val(day.format("YYYY-MM-DD"))
    $("#add-date input[name='existing_name']").val("")
    $("#add-date .friendly-day").text(day.format("dddd, MMMM Do, YYYY"))
    $("#add-date").modal("show")

$ ->
    $("#calendar").fullCalendar
        dayClick: window.dayClick
        validRange:
            start: window.minDate
            end: window.maxDate
