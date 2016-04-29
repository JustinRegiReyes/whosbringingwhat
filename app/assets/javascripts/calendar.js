// Call this from the developer console and you can control both instances
$(document).ready( function() {
    console.info(
        'Welcome to the CLNDR demo. Click around on the calendars and' +
        'the console will log different events that fire.');

    // Assuming you've got the appropriate language files,
    // clndr will respect whatever moment's language is set to.
    // moment.locale('ru');

    // Here's some magic to make sure the dates are happening this month.
    var thisMonth    = moment().format('YYYY-MM');
    var nextMonth    = moment().add(1, 'month').format('YYYY-MM');
    // Events to load into calendar
    var eventArray = [
        {
            title: 'Multi-Day Event',
            endDate: thisMonth + '-14',
            startDate: thisMonth + '-10'
        }, {
            endDate: thisMonth + '-23',
            startDate: thisMonth + '-21',
            title: 'Another Multi-Day Event'
        }, {
            date: thisMonth + '-27',
            title: 'Single Day Event'
        },
        { date: thisMonth + '-' + '10', title: 'Persian Kitten Auction', location: 'Center for Beautiful Cats' },
        { date: thisMonth + '-' + '19', title: 'Cat Frisbee', location: 'Jefferson Park' },
        { date: thisMonth + '-' + '23', title: 'Kitten Demonstration', location: 'Center for Beautiful Cats' },
        { date: nextMonth + '-' + '07',    title: 'Small Cat Photo Session', location: 'Center for Cat Photography' }
    ];

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
            endDate: 'endDate',
            startDate: 'startDate'
        },
        extras: null,
        showAdjacentMonths: true,
        adjacentDaysChangeMonth: true,
        ready: null,
        constraints: null,
        forceSixRows: false,
        daysOfTheWeek: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    });

});

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