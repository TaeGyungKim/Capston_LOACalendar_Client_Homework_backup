import 'package:flutter/material.dart';
import 'package:flutter1/ui/CalendarUI.dart';
import 'package:get/get.dart';

import 'ui/HomePage.dart';
import 'package:flutter1/ui/SearchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = '로아 숙제';

    return GetMaterialApp(
      initialRoute: '/',

      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(

      length: 3,
      child: Scaffold(

        appBar: AppBar(
          title: Text(appTitle),

        bottom:  const TabBar(
          tabs: [
             Tab(text: "일일 숙제"),
             Tab(text: "캘린더"),
             Tab(text: "아이템 검색"),
          ],
        ),
        ),
          body: const TabBarView(
            children: [

               MyHomePage(title: appTitle),

              CalendarPage(title: appTitle),
              SearchPage(title: appTitle),

            ],

          ) ,
        ),
      ),
      );
  }
}


