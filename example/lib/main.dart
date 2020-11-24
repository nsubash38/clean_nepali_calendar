import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Nepali Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NepaliCalendarController _nepaliCalendarController =
      NepaliCalendarController();

  @override
  Widget build(BuildContext context) {
    final NepaliDateTime first = NepaliDateTime(2075, 5);
    final NepaliDateTime last = NepaliDateTime(2079, 3);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Nepali Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CleanNepaliCalendar(
              headerDayBuilder: (_, index) {
                return Text('$_');
              },
              headerDayType: HeaderDayType.halfName,
              controller: _nepaliCalendarController,
              onHeaderLongPressed: (date) {
                print("header long pressed $date");
              },
              onHeaderTapped: (date) {
                print("header tapped $date");
              },
              calendarStyle: CalendarStyle(
                selectedColor: Colors.deepOrange,
                dayStyle: TextStyle(fontWeight: FontWeight.bold),
                todayStyle: TextStyle(
                  fontSize: 20.0,
                ),
                todayColor: Colors.orange.shade400,
                // highlightSelected: true,
                renderDaysOfWeek: true,
                highlightToday: true,
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: false,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20.0),
              ),
              initialDate: NepaliDateTime.now(),
              firstDate: first,
              lastDate: last,
              language: Language.nepali,
              onDaySelected: (day) {
                print(day.toString());
              },
              dateCellBuilder: (isToday, isSelected, isDisabled, nepaliDate,
                  label, text, calendarStyle) {
                print(isSelected);
                Decoration _buildCellDecoration() {
                  if (isSelected && isToday) {
                    return BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                        border: Border.all(color: calendarStyle.selectedColor));
                  }
                  if (isSelected) {
                    return BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: calendarStyle.selectedColor));
                  } else if (isToday && calendarStyle.highlightToday) {
                    return BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.blue,
                    );
                  } else {
                    return BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                    );
                  }
                }

                return AnimatedContainer(
                  padding: EdgeInsets.all(3),
                  duration: Duration(milliseconds: 2000),
                  decoration: _buildCellDecoration(),
                  child: Center(
                    child: Semantics(
                      label: label,
                      selected: isSelected,
                      child: ExcludeSemantics(
                        child: Column(
                          children: [
                            Text(text, style: TextStyle(fontSize: 20)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                  nepaliDate.toDateTime().day.toString(),
                                  style: TextStyle(fontSize: 8)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
