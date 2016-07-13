// Call this from the developer console and you can control both instances
$(document).ready(clndrPage);
$(document).on('page:load', clndrPage);

function clndrPage() {
    calendar();
    markDates(calendar());
}

function calendar() {
    // Assuming you've got the appropriate language files,
    // clndr will respect whatever moment's language is set to.
    // moment.locale('ru');

    // Here's some magic to make sure the dates are happening this month.
    var thisMonth    = moment().format('YYYY-MM');
    var nextMonth    = moment().add(1, 'month').format('YYYY-MM');
    // Events to load into calendar
    var eventArray = [
        {
            title: 'Camping',
            date_end: thisMonth + '-14',
            date_start: thisMonth + '-10',
            description: 'description', id: 1,
            user: {
                username: "Roro"
            }
        }, {
            date_end: thisMonth + '-23',
            date_start: thisMonth + '-10',
            title: 'Board Game Night', description: 'description', id: 2,
            user: {
                username: "Roro"
            }
        }, {
            date_start: thisMonth + '-27',
            title: 'Single Day Event', description: 'description', id: 3,
            user: {
                username: "Roro"
            }
        },
        { date_start: thisMonth + '-' + '10', title: 'Persian Kitten Auction', location: 'Center for Beautiful Cats', description: 'description', id: 4,
        user: {
            username: "Roro"
        } },
        { date_start: thisMonth + '-' + '19', title: 'Cat Frisbee', location: 'Jefferson Park', description: 'description', id: 5,
        user: {
            username: "Roro"
        } },
        { date_start: thisMonth + '-' + '23', title: 'Kitten Demonstration', location: 'Center for Beautiful Cats', description: 'description', id: 6,
        user: {
            username: "Roro"
        } },
        { date_start: nextMonth + '-' + '07',    title: 'Small Cat Photo Session', location: 'Center for Cat Photography', description: 'description', id: 7,
        user: {
            username: "Roro"
        } }
    ];
    // sort the eventArray based on its date_start
    eventArray.sort(function(a, b){
      if (a.date_start > b.date_start) {
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
            },
            previousMonth: function () {
            },
            onMonthChange: function () {
                var currentMonth = formatDate(this.month._d);
                var nextMonth    = moment(currentMonth).add(1, 'month').format('YYYY-MM');
                var prevMonth    = moment(currentMonth).subtract(1, 'month').format('YYYY-MM');
                var prevMonthDays = $('div[class*=calendar-day-' + prevMonth + ']');
                var nextMonthDays = $('div[class*=calendar-day-' + nextMonth + ']');
                addPrevMonthClass(prevMonthDays);
                addNextMonthClass(nextMonthDays);
                // console.log('prevMonthDays', prevMonthDays);
                // console.log('month', currentMonth);
                // console.log('nextMonth', nextMonth);
                // console.log('prevMonth', prevMonth);
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
    
    return dates;
};

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

function markDates(dates) {
    var eventDaysContainer = '<div class="event-days-container"><i class="fa fa-times close" aria-hidden="true"></i></div>';
    dates.forEach(function(date) {
        $('div[class*=' + date + '] span').css({"color": "#4095F8", "cursor": "pointer"});
        $('div[class*=' + date + ']').addClass("eventDay");
        $('div[class*=' + date + ']').append(eventDaysContainer);
    });

    $('body').on('click', '.eventDay', function(event) {
        if(event.target === this) {
            $(this).children("div.event-days-container").fadeIn(100);
            $(this).css({"border": "none"});
        }
    })
    $('body').on('click', '.eventDay .close', function(el) {
        // console.log('close');
        // $(this).parent().children("div.event-days-container").fadeOut(100);
        $(this).parent().fadeOut(100);
    })
}

function eventDaysCompiler() {

}