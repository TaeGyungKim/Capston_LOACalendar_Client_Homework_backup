import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import '../api/IslandAPI.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
    //late final Future<Island> island;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      key: scaffoldKey,

      body: Center(
          child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
              children:  const <Widget>[
             // SizedBox(height: 300, width: 300,
             // child:
              Image(image: AssetImage('asset/calender.png')
              ),
              //),
        ],

    ),

    ),
        )
    );
  }
}
