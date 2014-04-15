var api_filters = "/calendar-json/filters.json";
var api_events = "/events";
var urlSignIn = '/users/sign_in';
var urlRegister = '/pricing';
var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];
var date = new Date();
var date = new Date(date.getUTCFullYear(), date.getUTCMonth() + 1, 0);
var from = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + 1;
var to = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate(0);
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

function addAdminEventLinks(event_id, admin) {
  if (admin) {
    return '<div class="edit-event"><a href="/admin/events/' + event_id + '/edit">Edit</a></div>' +
           '<div class="delete-event"><a href="/admin/events/' + event_id + '" data-method="delete">Delete</a></div>'
  } else {
    return ""
  }
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
                date = new Date(val.audition_date);
                eventDates.push(date.getUTCFullYear() + '-' + (date.getUTCMonth() + 1) + '-' + date.getUTCDate());
                eventCount++;
                $('.calendar-events').append(
                        '<div class="calendar-event row" id="calendar-event-' + key + '" data-date="' + date.getUTCMonth() + '-' + date.getUTCDate() + '">' +
                        '<div class="calendar-date col-sm-2">' +
                        '<div class="calendar-month">' + monthNames[date.getUTCMonth()] + '</div>' +
                        '<div class="calendar-day">' + date.getUTCDate() + '</div>' + addAdminEventLinks(val.id, data.meta.admin) +
                        '</div>' +
                        '<div class="col-sm-10">' +
                        '<div class="calendar-name">' + val.name + '</div></h1>' +
                        '<div class="calendar-paid calendar-paid-' + val.paid + '">Paid?</div>' +
                        '<div id="calendar-overview-' + key + '" class="calendar-overview clearfix">' +
                        '<div class="calendar-attribute region"><span>Region:</span> ' + val.region + '</div>' +
                        '<div class="calendar-attribute project-type"><span>Project Type:</span> ' + val.project_type + '</div>' +
                        '<div class="calendar-attribute performer-type"><span>Performer Type:</span> ' + val.performer_type + '</div>' +
                        '</div>' +
                        '<div id="calendar-detail-' + key + '" class="calendar-detail"></div>' +
                        '<div id="calendar-expand-' + key + '" class="calendar-shrink ">More Information</div>' +
                        '</div>'
                        );
                $('#calendar-expand-' + key).click(function() {
                    $('#calendar-detail-' + key).slideToggle("slow");
                    $(this).toggleClass('calendar-expand');
                });
                if (data.meta.member == true) {
                    $('#calendar-detail-' + key).append(
                            '<div class="calendar-description story"><span>Storyline:</span> ' + val.story + '</div>',
                            '<div class="calendar-description description"><span>Description:</span> ' + val.description + '</div>',
                            '<div class="calendar-description audition"><span>How to Audition:</span> ' + val.audition + '</div>'
                            );
                    $('#calendar-overview-' + key).append(
                            '<div class="calendar-attribute start-date"><span>Shoot/Start Date:</span> ' + val.start_date + '</div>',
                            '<div class="calendar-attribute character"><span>Character:</span> ' + val.character + '</div>',
                            '<div class="calendar-attribute pay"><span>Pay Rate:</span> ' + val.pay + '</div>',
                            '<div class="calendar-attribute union"><span>Union Status:</span> ' + val.union + '</div>',
                            '<div class="calendar-attribute director"><span>Casting Director:</span> ' + val.director + '</div>',
                            '<div class="calendar-attribute end-date"><span>Shoot/End Date:</span> ' + val.end_date + '</div>'
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
                    to = new Date(from.getUTCFullYear(), from.getUTCMonth() + 1, 0);
                    search.date.start = from.getUTCFullYear() + "-" + (from.getUTCMonth() + 1) + "-" + from.getUTCDate();
                    search.date.end = to.getUTCFullYear() + "-" + (to.getUTCMonth() + 1) + "-" + to.getUTCDate();
                    calendarUpdate();
                },
                beforeShowDay: function(date) {
                    var m = date.getUTCMonth(), d = date.getUTCDate(), y = date.getUTCFullYear();
                    for (i = 0; i < eventDates.length; i++) {
                        if ($.inArray(y + '-' + (m + 1) + '-' + d, eventDates) != -1) {
                            return [true, 'calendar-matched-event-date'];
                        }
                        return [false, 'calendar-not-matched-event-date'];
                    }
                },
                onSelect: function(date) {
                    date = new Date(date)
                    target = $('[data-date="' + date.getUTCMonth() + '-' + date.getUTCDate() + '"]');
                    $("html,body").animate({scrollTop: target.offset().top}, 500);
                }
            });
        }
    });
}