// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(primaryColor: Colors.blue),
        // home: MainApp(),
        initialRoute: '/',
        routes: {
          '/': (context) => MainApp(),
          '/events_screen': (context) => EventScreen()
        });
  }
}

// shortcut to generate: stful
class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    SchedulePage(optionStyle: optionStyle),
    StatisticsPage(optionStyle: optionStyle),
    ActionsPage(optionStyle: optionStyle),
    SettingsPage(optionStyle: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // DateFormat dayFormat = DateFormat('d');
    DateFormat weekdayFormat = DateFormat('EE');
    print(now.weekday + 1);

    List days = [];
    List weekdays = [];
    for (var i = 0; i <= 6; i++) {
      days.add((now.day + i).toString());
      weekdays.add(weekdayFormat.format(DateTime(now.weekday + i)));
    }

    _tabController = TabController(length: 7, vsync: this);

    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Date"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: weekdays[0] + "\n" + days[0],
            ),
            Tab(
              text: weekdays[1] + "\n" + days[1],
            ),
            Tab(
              text: weekdays[2] + "\n" + days[2],
            ),
            Tab(
              text: weekdays[3] + "\n" + days[3],
            ),
            Tab(
              text: weekdays[4] + "\n" + days[4],
            ),
            Tab(
              text: weekdays[5] + "\n" + days[5],
            ),
            Tab(
              text: weekdays[6] + "\n" + days[6],
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Shedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff327DF5),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    Key key,
    @required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: Card(
          color: Color(0xffe0e0e0),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, '/events_screen');
            },
            child: const Center(child: Text('No Event Added')),
          ),
        ),
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key key,
    @required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 1: Statistics',
      style: optionStyle,
    );
  }
}

class ActionsPage extends StatelessWidget {
  const ActionsPage({
    Key key,
    @required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 2: Tasks',
      style: optionStyle,
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key key,
    @required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 3: Settings',
      style: optionStyle,
    );
  }
}

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create an event")),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
