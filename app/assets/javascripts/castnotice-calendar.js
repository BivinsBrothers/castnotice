var api_filters = "filters.json";
var api_events = "events-member.json";
var urlSignIn = '';
var urlRegister = '';
var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];
var date = new Date();
var date = new Date(date.getFullYear(), date.getMonth() + 1, 0);
var from = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + 1;
var to = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate(0);
var search = {"date": {"start": from, "end": to}};
var eventDates = [""];
var eventCount;

function calendarBuild() {

    $.ajax({
        url: api_filters,
//        data: {// am I passing any data to get the filters data?},
        success: function(data) {
            $.each(data.filters, function(key, val) {
                $('.calendar-filters').append(
                        '<div class="calendar-option" id="filter-' + key + '" data-filter="' + key + '"><h3>' + val.label + '</h3></div>'
                        );
                $.each(val.values, function(i, option) {
                    $("#filter-" + key).append('<div class="calendar-checkbox"><input type="checkbox" id="filter-' + key + '-' + i + '" name="' + key + '" value="' + option + '"> <label for="filter-' + key + '-' + i + '">' + option + "</label></div>");
                });
            });
            $('.calendar-checkbox input').change(function() {
                calendarUpdate();
            });
            calendarUpdate();
        },
        dataType: "json"
    });
}

function calendarUpdate() {
    $.ajax({
        url: api_events,
        beforeSend: function() {
            search.filters = {};
            date = $('#calendar-datepicker').datepicker('getDate');
            $('.calendar-option').each(function() {
                filterName = ($(this).attr('data-filter'));
                filterValues = [];
                $(this).find('input').each(function() {
                    if ($(this).prop('checked')) {
                        filterValues.push($(this).val());
                        ('<p>' + $(this).val() + '</p>');
                    }
                });
                search.filters[filterName] = filterValues;

            });
        },
        data: search,
        success: function(data) {
            $('.calendar-events').html('');
            eventCount = 0;
            $.each(data.events, function(key, val) {
                date = new Date(val.date);
                eventDates.push(date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate());
                eventCount++;
                $('.calendar-events').append(
                        '<div class="calendar-event row" id="calendar-event-' + key + '" data-date="' + date.getMonth() + '-' + date.getDate() + '">' +
                        '<div class="calendar-date col-sm-2">' +
                        '<div class="calendar-month">' + monthNames[date.getMonth()] + '</div>' +
                        '<div class="calendar-day">' + date.getDate() + '</div>' +
                        '</div>' +
                        '<div class="col-sm-10">' +
                        '<div class="calendar-name">' + val.name + '</div></h1>' +
                        '<div class="calendar-paid calendar-paid-' + val.paid + '">Paid?</div>' +
                        '<div id="calendar-overview-' + key + '" class="calendar-overview clearfix">' +
                        '<div class="calendar-attribute"><span>Region:</span> ' + val.region + '</div>' +
                        '<div class="calendar-attribute"><span>Project Type:</span> ' + val.project + '</div>' +
                        '<div class="calendar-attribute"><span>Performer Type:</span> ' + val.performer + '</div>' +
                        '</div>' +
                        '<div id="calendar-detail-' + key + '" class="calendar-detail"></div>' +
                        '<div id="calendar-expand-' + key + '" class="calendar-shrink ">More Information</div>' +
                        '</div>'
                        );
                $('#calendar-expand-' + key).click(function() {
                    $('#calendar-detail-' + key).slideToggle("slow");
                    $(this).toggleClass('calendar-expand');
                });
                if (data.member == true) {
                    $('#calendar-detail-' + key).append(
                            '<div class="calendar-description"><span>Storyline:</span> ' + val.story + '</div>',
                            '<div class="calendar-description"><span>Description:</span> ' + val.description + '</div>',
                            '<div class="calendar-description"><span>How to Audition:</span> ' + val.audition + '</div>'
                            );
                    $('#calendar-overview-' + key).append(
                            '<div class="calendar-attribute"><span>Shoot/Start Date:</span> ' + val.start + '</div>',
                            '<div class="calendar-attribute"><span>Character:</span> ' + val.character + '</div>',
                            '<div class="calendar-attribute"><span>Pay Rate:</span> ' + val.pay + '</div>',
                            '<div class="calendar-attribute"><span>Union Status:</span> ' + val.union + '</div>',
                            '<div class="calendar-attribute"><span>Casting Director:</span> ' + val.director + '</div>',
                            '<div class="calendar-attribute"><span>Shoot/End Date:</span> ' + val.end + '</div>'
                            );
                } else {
                    $('#calendar-detail-' + key).append(
                            '<p>To find out detailed information about this event, you must be logged into CastNotice. Please <a href="' + urlSignIn + '">Sign in</a> or <a href="' + urlRegister + '">Register</a></p></div>'
                            );
                }
            });
            if (eventDates.length === 1) {
                $('.calendar-events').html('<p>Sorry, no events match your search criteria, please change your selection.</p>');
            }
            $("#calendar-datepicker").datepicker({"onChangeMonthYear": function(year, month) {
                    from = new Date(year, month - 1);
                    to = new Date(from.getFullYear(), from.getMonth() + 1, 0);
                    search.date.start = from.getFullYear() + "-" + (from.getMonth() + 1) + "-" + from.getDate();
                    search.date.end = to.getFullYear() + "-" + (to.getMonth() + 1) + "-" + to.getDate();
                    calendarUpdate();
                },
                beforeShowDay: function(date) {
                    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
                    for (i = 0; i < eventDates.length; i++) {
                        if ($.inArray(y + '-' + (m + 1) + '-' + d, eventDates) != -1) {
                            return [true, 'calendar-matched-event-date'];
                        }
                        return [false, 'calendar-not-matched-event-date'];
                    }
                },
                onSelect: function(date) {
                    date = new Date(date)
                    target = $('[data-date="' + date.getMonth() + '-' + date.getDate() + '"]');
                    $("html,body").animate({scrollTop: target.offset().top}, 500);
                }
            });
        }
    });
}