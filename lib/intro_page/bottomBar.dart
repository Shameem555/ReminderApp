import 'package:flutter/material.dart';
import 'package:reminder/model/data_model.dart';
import 'package:reminder/screen/ListScreen.dart';
import 'package:reminder/screen/chart.dart';
import 'package:reminder/screen/eventscreen.dart';
import 'package:reminder/screen/homeScreen.dart';
import 'package:reminder/settings/settings.dart';
import 'package:reminder/widgets/utility.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final tabs = [
    const HomeScreen(),
    const EventScreen(),
    const Chart(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: eventviewListNotifier,
      builder: (BuildContext ctx, List<EventModel> eventlists, Widget? child) {
        return Scaffold(
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue[200],
            iconSize: 25,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_sharp),
                label: 'Note',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Chart',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications),
                label: 'Settings',
                backgroundColor: Colors.blue,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (_currentIndex == 2) {
                  allList(alldatalist: eventlists);
                  //for today chart filter
                  todayscreenchart tdy = todayscreenchart();
                  tdy.todayList(alldatalist: eventlists);
                  tdy.checkconditions();
                  //for yersterday chart filter
                  yesterday_screenchart ydy = yesterday_screenchart();
                  ydy.yesterdayList(alldatalist: eventlists);
                  ydy.checkconditions();
                }
              });
            },
          ),
        );
      },
    );
  }
}
