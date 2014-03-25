var api_filters = "filters.json";
var api_events = "events.json";

var filters;
var events;
var today = new Date();
var from = today.getDate() + "/" + (today.getMonth() + 1) + "/" + today.getFullYear();
var to = today.getDate() + "/" + (today.getMonth() + 2) + "/" + today.getFullYear();

function calendarBuild() {

    $("#calendar-from").val(from);
    $("#calendar-to").val(to);

    $("#calendar-from").datepicker({
        changeMonth: true,
        numberOfMonths: 3,
        onClose: function(selectedDate) {
            $("#to").datepicker("option", "minDate", selectedDate);
        }
    });
    $("#calendar-to").datepicker({
        defaultDate: "+1m",
        changeMonth: true,
        numberOfMonths: 3,
        onClose: function(selectedDate) {
            $("#from").datepicker("option", "maxDate", selectedDate);
        }
    });

    $("#calendar-search").click(function() {
        calendarUpdate();
    });

    $.ajax({
        url: api_filters,
        data: {
            "from": from,
            "to": to
        },
        beforeSend: function() {

            $('.calendar-filter-option select').each(function() {
                alert($(this).val());
            });
        },
        success: function(data) {

            $.each(data.filters, function(key, val) {
                $('.calendar-filters').append(
                        '<div class="calendar-filter-option" id="filter-' + key + '">' + val.label + '</div>'
                        );
                $.each(val.values, function(i, option) {
                    $("#filter-" + key).append('<div class="calendar-filter-checkbox"><input type="checkbox" id="filter-' + key + '-' + option + '" name="' + key + '" value="' + option + '"> <label for="filter-' + key + '-' + option + '">' + option + "</label></div>");
                });
            });
        },
        dataType: "json"
    });



}

function calendarUpdate() {
//$.ajax({
//    url: api_events,
//    success: function(data) {
//        $.each(data.)
//    }
//});
}