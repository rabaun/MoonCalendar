import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_calendar/phases.dart';
import 'package:moon_calendar/styles.dart';
import 'package:table_calendar/table_calendar.dart';

import 'ekadashi.dart';
import 'event.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  Widget _buildDefineIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              'icons/growing_moon.svg',
              height: 10,
            ),
            const SizedBox(height: 6),
            const Text(
              'Растущая\nлуна',
              style: TextStyle(fontSize: 10, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(
              'icons/full_moon.svg',
              height: 10,
            ),
            const SizedBox(height: 6),
            const Text(
              'Полнолуние',
              style: TextStyle(fontSize: 10, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(
              'icons/waning_moon.svg',
              height: 10,
            ),
            const SizedBox(height: 6),
            const Text(
              'Убывающая\nлуна',
              style: TextStyle(fontSize: 10, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(
              'icons/ekadashi.svg',
              height: 10,
            ),
            const SizedBox(height: 6),
            const Text(
              'Экадеши',
              style: TextStyle(fontSize: 10, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
            decoration: BoxDecoration(
              color: backgroundWidget,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, -0),
                  child: _buildDefineIcons(),
                ),
                const SizedBox(height: 6),
                TableCalendar(
                  locale: 'ru',
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, _) {
                      return Container(
                        child: Row(
                          children: [
                            if (isFullMoon(date))
                              Expanded(
                                  flex: 1,
                                  child: SvgPicture.asset('icons/full_moon.svg',
                                      height: 10)),
                            if (isEkadashi(date))
                              Expanded(
                                flex: 1,
                                child: SvgPicture.asset(
                                  'icons/ekadashi.svg',
                                  height: 10,
                                ),
                              ),
                            if (isWaxingMoon(date))
                              Expanded(
                                  child: SvgPicture.asset(
                                      'icons/growing_moon.svg',
                                      height: 10)),
                            if (isWaningMoon(date))
                              Expanded(
                                  child: SvgPicture.asset(
                                      'icons/waning_moon.svg',
                                      height: 10)),
                          ],
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 25.0,
                        height: 25.0,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      );
                    },
                  ),

                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,

                  //Day Changed
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                    });
                    print(focusedDay);
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },

                  eventLoader: _getEventsfromDay,

                  //To style the Calendar
                  calendarStyle: CalendarStyle(
                    weekNumberTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white),
                    rangeStartTextStyle: TextStyle(color: Colors.white),
                    rangeEndTextStyle: TextStyle(color: Colors.white),
                    outsideTextStyle: TextStyle(color: Colors.white),
                    holidayTextStyle: TextStyle(color: Colors.white),
                    disabledTextStyle: TextStyle(color: Colors.white),
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    todayDecoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        border: Border.all(
                          color: borderColor,
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    defaultDecoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    weekendDecoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  headerVisible: true,
                  headerStyle: HeaderStyle(
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ..._getEventsfromDay(selectedDay).map(
                  (Event event) => ListTile(
                    title: Text(
                      event.title,
                    ),
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
