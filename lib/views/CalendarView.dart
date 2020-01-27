import 'package:flutter/material.dart';
import 'package:impuls/pages/EventDetailPage.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:impuls/providers/EventsProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  CalendarView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(_calendarController.selectedDay);
  }

  void fetchEvents(context) {
    EventsProvider eventsProvider =
        Provider.of<EventsProvider>(context, listen: false);
    eventsProvider.fetchAllEvents();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    fetchEvents(context);
    setState(() {
      setSelectedDay(day);
    });
  }

  void setSelectedDay(DateTime day) {
    final EventsProvider eventsProvider =
        Provider.of<EventsProvider>(context, listen: false);
    eventsProvider.setSelectedDay(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    fetchEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: _buildTableCalendarWithBuilders(),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
              )
            ],
          ),
        ),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  // Simple TableCalendar configuration (using Styles)

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    final EventsProvider eventsProvider = Provider.of<EventsProvider>(context);

    return Container(
      color: Colors.white,
      child: TableCalendar(
        locale: 'nb_NO',
        calendarController: _calendarController,
        events: eventsProvider.mappedEvents,
//        events: _events,
//      holidays: _holidays,
        initialCalendarFormat: CalendarFormat.week,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Måned',
          CalendarFormat.week: 'Uke',
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendStyle: TextStyle().copyWith(
              color: colorTheme.mainColor, fontWeight: FontWeight.bold),
//        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity:
                  Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: ClipOval(
                child: Container(
                  color: colorTheme.secondaryColor,
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 3.0, color: colorTheme.secondaryColor),
                borderRadius: BorderRadius.all(Radius.circular(
                        4.0) //                 <--- border radius here
                    ),
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              ),
            );
          },
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }

            return children;
          },
        ),
        onDaySelected: (date, events) {
          print(date);
          _onDaySelected(date, events);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration:
          BoxDecoration(shape: BoxShape.rectangle, color: colorTheme.mainColor),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    final EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Container(
        color: colorTheme.secondaryColor,
        child: AnimatedOpacity(
          opacity: eventsProvider.selectedEvents.length > 0 ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: eventsProvider.selectedEvents
                .map((event) => EventListItem(event: event))
                .toList(),
          ),
        ));
  }
}

class EventListItem extends StatelessWidget {
  final event;

  const EventListItem({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);

//    String Formatting
    //Start & End-time
    final startTime = event.startTime != null
        ? new DateFormat("HH:mm").format(event.startTime)
        : '';
    final endTime = event.endTime != null
        ? "\n${new DateFormat("HH:mm").format(event.endTime)}"
        : '';

    //Location
    final location = event.location != null ? "\nSted: ${event.location}" : '';

    return Hero(
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Text("$startTime$endTime"),
          dense: true,
          trailing: event.description != null
              ? Icon(Icons.keyboard_arrow_right,
                  color: Colors.black38, size: 30.0)
              : SizedBox.shrink(),
          title: Text("${event.title ?? ''}$location"),
          subtitle: Text(
            "${event.description ?? ''}",
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailPage(
                event: event,
              ),
            ),
          ),
        ),
      ),
      tag: event.id,
    );
  }
}
