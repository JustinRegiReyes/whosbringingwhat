// Call this from the developer console and you can control both instances

function calendar() {
    // Assuming you've got the appropriate language files,
    // clndr will respect whatever moment's language is set to.
    // moment.locale('ru');

    // Here's some magic to make sure the dates are happening this month.
    var thisMonth    = moment().format('YYYY-MM');
    var nextMonth    = moment().add(1, 'month').format('YYYY-MM');
    var twoMonth    = moment().add(2, 'month').format('YYYY-MM');

    $.get('/calendar/events', undefined, onSuccess);
};

function onSuccess(data) {
    var eventArray = data;
    // Events to load into calendar
    // var eventArray = [
    //     {
    //         title: 'Camping!!!',
    //         date_end: thisMonth + '-14',
    //         date_start: thisMonth + '-10',
    //         date: thisMonth + '-10',
    //         description: 'description', id: 1,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, {
    //         date_end: thisMonth + '-23',
    //         date_start: thisMonth + '-10',
    //         date: thisMonth + '-10',
    //         title: 'Board Game Night', description: 'description', id: 2,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, {
    //         date_start: thisMonth + '-27',
    //         date: thisMonth + '-27',
    //         title: 'Single Day Event', description: 'description', id: 3,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, {
    //         date_start: nextMonth + '-17',
    //         date: nextMonth + '-17',
    //         title: 'Single Day Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, 
    //     {
    //         date_start: nextMonth + '-17',
    //         date: nextMonth + '-17',
    //         title: 'Working Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: nextMonth + '-18',
    //         date: nextMonth + '-18',
    //         title: 'Working Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: nextMonth + '-18',
    //         date: nextMonth + '-18',
    //         title: 'Working Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: twoMonth + '-19',
    //         date: twoMonth + '-19',
    //         title: 'Next Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: twoMonth + '-19',
    //         date: twoMonth + '-19',
    //         title: 'Next Event', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, 
    //     {
    //         date_start: twoMonth + '-20',
    //         date: twoMonth + '-20',
    //         title: 'Fish Tacos', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: twoMonth + '-20',
    //         date: twoMonth + '-20',
    //         title: 'Fish Tacos', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     },
    //     {
    //         date_start: twoMonth + '-21',
    //         date: twoMonth + '-21',
    //         title: 'Fish Tacos', description: 'description', id: 7,
    //         user: {
    //             username: "Roro"
    //         }
    //     }, 
    //     { date_start: thisMonth + '-10', date: thisMonth + '-10', title: 'Persian Kitten Auction', location: 'Center for Beautiful Cats', description: 'description', id: 4,
    //     user: {
    //         username: "Roro"
    //     } },
    //     { date_start: thisMonth + '-19', date: thisMonth + '-19', title: 'Cat Frisbee', location: 'Jefferson Park', description: 'description', id: 5,
    //     user: {
    //         username: "Roro"
    //     } },
    //     { date_start: thisMonth + '-23', date: thisMonth + '-19', title: 'Kitten Demonstration', location: 'Center for Beautiful Cats', description: 'description', id: 6,
    //     user: {
    //         username: "Roro"
    //     } },
    //     { date_start: nextMonth + '-07', date: nextMonth + '-07', title: 'Small Cat Photo Session', location: 'Center for Cat Photography', description: 'description', id: 7,
    //     user: {
    //         username: "Roro"
    //     } }
    // ];
    // sort the eventArray based on its date_start
    eventArray.sort(function(a, b){
      if (a.date_start >= b.date_start) {
        return 1;
      }
      if (a.date_start < b.date_start) {
        return -1;
      }
      // a must be equal to b
      return 0;
    })

    // declare an empty array to push in dates that are duplicates
    var dates = [];
    var last;
    // groups events on the same date so I can go through them in the view without stating the day repeatedly
    eventArray.forEach(function(e){
      if(e.date_start && last !== e.date_start) {
        last = e.date_start;
        dates.push(e.date_start);
      }
    });

    // The order of the click handlers is predictable. Direct click action
    // callbacks come first: click, nextMonth, previousMonth, nextYear,
    // previousYear, nextInterval, previousInterval, or today. Then
    // onMonthChange (if the month changed), inIntervalChange if the interval
    // has changed, and finally onYearChange (if the year changed).
    // calendars.clndr1 = $('.cal1').clndr({
    //     template: $('#full-clndr-template').html(),
    //     events: eventArray,
    //     forceSixRows: true
    // });
    // put events in window to test w/
    window.events = eventArray;
    window.clndr = $('.cal').clndr({
        events: eventArray,
        doneRendering: function () {
            var currentMonth = formatDate(this.month._d);
            var nextMonth    = moment(currentMonth).add(1, 'month').format('YYYY-MM');
            var prevMonth    = moment(currentMonth).subtract(1, 'month').format('YYYY-MM');
            var prevMonthDays = $('div[class*=calendar-day-' + prevMonth + ']');
            var nextMonthDays = $('div[class*=calendar-day-' + nextMonth + ']');
            addPrevMonthClass(prevMonthDays);
            addNextMonthClass(nextMonthDays);
        },
        clickEvents: {
            click: function (target) {
                // console.log('Cal-1 clicked: ', target);
            },
            today: function () {
                console.log('Cal-1 today');
            },
            nextMonth: function () { 
                markDates(dates);
                eventDaysCompiler(eventArray, dates);
            },
            previousMonth: function () {
                markDates(dates);
                eventDaysCompiler(eventArray, dates);
            },
            onMonthChange: function () {
                var currentMonth = formatDate(this.month._d);
                var nextMonth    = moment(currentMonth).add(1, 'month').format('YYYY-MM');
                var prevMonth    = moment(currentMonth).subtract(1, 'month').format('YYYY-MM');
                var prevMonthDays = $('div[class*=calendar-day-' + prevMonth + ']');
                var nextMonthDays = $('div[class*=calendar-day-' + nextMonth + ']');
                addPrevMonthClass(prevMonthDays);
                addNextMonthClass(nextMonthDays);
            },
            nextYear: function () {
                console.log('Cal-1 next year');
            },
            previousYear: function () {
                console.log('Cal-1 previous year');
            },
            onYearChange: function () {
                console.log('Cal-1 year changed');
            },
            nextInterval: function () {
                console.log('Cal-1 next interval');
            },
            previousInterval: function () {
                console.log('Cal-1 previous interval');
            },
            onIntervalChange: function () {
                console.log('Cal-1 interval changed');
            }
        },
        template: $('#full-clndr-template').html(),
        classes: {
            past: "past",
            today: "today",
            event: "event",
            selected: "selected",
            inactive: "inactive",
            lastMonth: "last-month",
            nextMonth: "next-month",
            adjacentMonth: "adjacent-month",
        },
        multiDayEvents: {
            singleDay: 'date',
            date_end: 'date_end',
            date_start: 'date_start'
        },
        extras: null,
        showAdjacentMonths: true,
        adjacentDaysChangeMonth: true,
        ready: null,
        constraints: null,
        forceSixRows: false,
        daysOfTheWeek: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    });
    
    markDates(dates);
    eventDaysCompiler(eventArray, dates);
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

function addPrevMonthClass(elements) {
    elements.addClass('prevMonth');
}

function addNextMonthClass(elements) {
    elements.addClass('nextMonth');
}

// marks the dates with events on them with colored dates
// attaches event listeners to every day with events on them
function markDates(dates) {
    // goes through every date and colors the span within it a certain color
    // adds class "eventDay" to every element with the date in the dates array
    // appends a event days container that contains the events on that date
    dates.forEach(function(date) {
        $('div[class*=' + date + '] span').css({"cursor": "pointer"});
        $('div[class*=' + date + ']').addClass("eventDay");

        $("[class*=" + date + "]").unbind( "click" );
        $('[class*=' + date + '] .close').unbind("click");

        // event listener on the child of eventDays and only opens and closes the eventDays container
        $('div.clndr-grid').on('click', "[class*=" + date + "]", function(event) {
            var dayChildEl = $(this).context.firstChild;
            // if the eventTarget is equal to the child of eventDays or eventDays then it opens or closes
            if((event.target === this || event.target === dayChildEl) && this.open !== true) {
                this.open = true;
                $(this).children("div.event-days-container").fadeIn(100);
            } else if((event.target === this || event.target === dayChildEl) && this.open === true){
                this.open = false;
                $(this).children("div.event-days-container").fadeOut(100);
            }
        });

        // an event listener on an icon in the eventDays container
        $('div.clndr-grid').on('click', '[class*=' + date + '] .close', function(event) {
            // the parent of the appended div.eventDays gets changed to open = false
            $(this).closest('.eventDay')[0].open = false;
            $(this).parent().fadeOut(100);
        });
    });

}

// takes the dates and appends an .event-days-container to display the different events within that date
function eventDaysCompiler(events, dates) {
    // html markup for the .event-days-container with some elements inside
    var eventDaysContainerOpen = '<div class="event-days-container"><i class="fa fa-times close" aria-hidden="true"></i><h5>';
    var eventDaysContainerClose = '</h5></div>';

    // goes through each date and appends the .event-days-container
    dates.forEach(function(date) {
        // variables to take the date out of the date obj
        var mydate = new Date(date);
        var monthNum = mydate.getMonth();
        var dayNum = mydate.getDay();
        var theDate = mydate.getUTCDate();
        var month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][monthNum];
        var day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"][dayNum];
        var eventDate = day + " " + theDate;

        $('div[class*=' + date + ']').append(eventDaysContainerOpen + eventDate + eventDaysContainerClose);
    });

    events.forEach(function(event) {
        var title = event.title;
        var eventTitleEl = '<div class="event-title-container"><a href="/events/' + event.id +  '"><span class="event-title">' + title + '</span></a></div>';

        $('div[class*=' + event.date_start + '] .event-days-container').append(eventTitleEl);
    });

    $('.eventDay').append('<i class="fa fa-circle" aria-hidden="true"></i>')
}