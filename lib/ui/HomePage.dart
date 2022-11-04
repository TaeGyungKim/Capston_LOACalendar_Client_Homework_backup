import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter1/api/Repository.dart';
//https://pub.dev/packages/custom_timer
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Timer/Calendar.dart';
import '../api/IslandAPI.dart';
import '../data/IslandData.dart';

//참조 : https://blog.naver.com/pjt3591oo/222599743256
//https://pub.dev/packages/get



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Island> island;
  late List<IslandElement> islandElement;
  final CustomTimerController _controller = CustomTimerController();
  String? selectedNotificationPayload;
  String _selectedTime = '';
  late Time alarmTime;

  //https://blog.naver.com/chandong83/222412178449
  //https://eory96study.tistory.com/26
  //https://pub.dev/packages/flutter_local_notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  @override
  void initState(){
    super.initState();
    island = fetchIsland();

    var initializationSettingsAndroid =const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //onSelectNotification의 경우 알림을 눌렀을때 어플에서 실행되는 행동을 설정하는 부분입니다.
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            debugPrint('notification payload: $payload');
          }
          selectedNotificationPayload = payload;
        }
    );
  }

  //알림
  Future onSelectNotification(String payload) async {
    print("payload : $payload");
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('connected'),
          content: Text('Payload: $payload'),
        ));
  }

  //매일 같은 시간 알림을 알려줍니다.
  Future _dailyAtTimeNotification() async {
    //24시간 표시
    var time = alarmTime;
    var android = const AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription:'your channel description',
        importance: Importance.max, priority: Priority.high);

    var detail = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      '알람',
      '설정된 알람',
      time,
      detail,
      payload: 'Hello Flutter',
    );
  }

//반복적으로 알림을 뜨게 히는 방법입니다.
  Future _repeatNotification() async {
    var android = const AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription:'your channel description',
        importance: Importance.max, priority: Priority.high);

    var detail = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '반복 Notification 내용',
      //ReapeatInterval.{EveryMinute, Hourly, Daily, Weekly} 중 선택하여 사용할수 있습니다.
      RepeatInterval.everyMinute,
      detail,
      payload: 'Hello Flutter',
    );
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width ~/ 3;
    Duration remainedIslandTime;
    Duration remainedChaosGateTime; //향후 배열로 개선
    Duration remainedFieldBossTime; 
    Duration remainedGhostShipTime; 
    Duration remainedLowenBattleTime; 
    Duration remainedLowenRvRTime; 
    Duration remainedEventTime; 


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        DefaultTextStyle(
        style: Theme.of(context).textTheme.headline5!,
        child: FutureBuilder<Island>(
        future: island,
        builder: (BuildContext context , AsyncSnapshot<Island> snapshot) {
          List<Widget> children;


          //비동기(네트워크) 데이터가 있다면
          if (snapshot.hasData) {
            //시작 날짜를 받아와서 남은 시간으로 타이머 작동
            remainedIslandTime = remainedIslandTimer(snapshot.data!.islandDate);

            // 타이머 데이터 가져옴 
            List<bool> calendarContent =CalendarTimer().isTodayCalendar();
            remainedChaosGateTime = CalendarTimer().chaosGateTimer(calendarContent);
            remainedFieldBossTime = CalendarTimer().fieldBossTimer(calendarContent);
            remainedGhostShipTime = CalendarTimer().ghostShipTimer(calendarContent);
            remainedLowenBattleTime = CalendarTimer().lowenRaidBattleTimer(calendarContent);
            remainedLowenRvRTime = CalendarTimer().lowenRvRTimer(calendarContent);
            remainedEventTime = CalendarTimer().occupationEventTimer(calendarContent);

            //타이머 컨트롤러 시작
            _controller.start();

            //받아온 데이터로 이미지값 매칭
            final matchedName = [
              IslandData().selectIslandName(snapshot.data!.island[0].name),
              IslandData().selectIslandName(snapshot.data!.island[1].name),
              IslandData().selectIslandName(snapshot.data!.island[2].name),
            ];

            final matchedReward = [
              IslandData().selectIslandReward(snapshot.data!.island[0].reward),
              IslandData().selectIslandReward(snapshot.data!.island[1].reward),
              IslandData().selectIslandReward(snapshot.data!.island[2].reward),
            ];


            children = <Widget>[

              //섬 이미지
              islandRowImage(
                  'asset/today/${matchedName[0]}',
                  'asset/today/${matchedName[1]}',
                  'asset/today/${matchedName[2]}' ,
                  width: width.toDouble()),

              //보상 이미지
              islandRowImage(
                  'asset/today/${matchedReward[0]}',
                  'asset/today/${matchedReward[1]}',
                  'asset/today/${matchedReward[2]}',
                  width: width.toDouble()),

              //Image(image: AssetImage('asset/today/'+matchedName[0])),
              //Image.asset('asset/today/'+matchedName[0], width: 200, height: 200),


              Text('모험섬 시작 시간 ${snapshot.data!.islandDate},  '),


              //섬 타이머
              CustomTimer(
                controller: _controller,
                begin: remainedIslandTime,
                end: const Duration(),
                builder: (remaining) {
                  return Text(
                      "모험섬 시작까지 남은 시간: ${remaining.hours}:${remaining.minutes}:${remaining.seconds}"
                  );}
                ),

              //이미지까지 만들면됨
              //각 컨텐츠 타이머 및 알람 설정
              if(remainedChaosGateTime != const Duration(seconds: -1))
                newTimer(_controller, remainedChaosGateTime, "카오스 게이트",width: width.toDouble() ),

              if(remainedFieldBossTime != const Duration(seconds: -1))
                newTimer(_controller, remainedFieldBossTime, "필드 보스",width: width.toDouble()  ),

              if(remainedGhostShipTime != const Duration(seconds: -1))
                newTimer(_controller, remainedGhostShipTime, "유령선",width: width.toDouble()  ),

              if(remainedLowenBattleTime != const Duration(seconds: -1))
                newTimer(_controller, remainedLowenBattleTime, "로웬 습격전",width: width.toDouble()  ),

              if(remainedLowenRvRTime != const Duration(seconds: -1))
                newTimer(_controller, remainedLowenRvRTime, "툴루비크",width: width.toDouble()  ),

              if(remainedEventTime != const Duration(seconds: -1))
                newTimer(_controller, remainedEventTime, "길드 점령전 이벤트",width: width.toDouble()  ),



                  ];

            //Error 발생 - 데이터를 가져오지 못할 경우
          } else if (snapshot.hasError) {
            children = <Widget>[

             Text("${snapshot.error}"),

             ];


            //데이터 받는 도중 대기
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting...'),
              )
            ];

          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          );
        },
        ),
        ),
      ],
    );

  }

  //좌우로 3장의 이미지 배치
  Widget islandRowImage(String leftPath, String midPath, String rightPath, {required double width}) {
    var resize = 10;

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
         Expanded(
           child:Container(
               padding: const EdgeInsets.all(1.0),
               child: Image.asset(leftPath, width: width-resize, height: width-resize*10)),
        ),
         Expanded(
           child: Container(
               padding: const EdgeInsets.all(1.0),
               child: Image.asset(midPath, width: width-resize, height: width-resize*10)),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(rightPath, width: width-resize, height: width-resize*10)),
        ),
      ],
    );
  }

  //타이머, 이때 텍스트 버튼 누르면 알람 시간 설정
  Widget newTimer(CustomTimerController newController, Duration remainedTime, String writeText, {required double width}){
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          OutlinedButton(
          child: CustomTimer(
              controller: newController,
              begin: remainedTime,
              end: const Duration(),
              builder: (remaining) {
                return SizedBox(height: 60, width: width*3-35,
                  child: Text(
                    style: const TextStyle(
                      fontSize: 25.0,),
                "$writeText 출현까지 " "${remaining.hours}:${remaining.minutes}:${remaining.seconds}"
                ),
                );
              }
              ),

            //누르면
            //https://blog.naver.com/devcosplay/222369086975
            onPressed: (){
            Future<TimeOfDay?> selectedTime = showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: '알람 시간을 입력해주세요',
              cancelText: '취소',
              confirmText: '확인',
            );
            //selectedTime에 데이터가 들어모면
            selectedTime.then((timeOfDay) {
              setState(() {
                if (timeOfDay != null) {
                  _selectedTime = '${timeOfDay.hour}:${timeOfDay.minute}';
                  alarmTime = Time( timeOfDay.hour, timeOfDay.minute, 0 );

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    // SnackBar가 출력되는 시간
                    // duration: const Duration(seconds: 2),

                    content: Text('$_selectedTime 알람 설정되었습니다.'),

                    // SnackBar의 오른쪽에 배치될 위젯
                    action: SnackBarAction(
                      label: "Done",
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ));
                }
              });
            });
            },
            ),

        ],


    );
    }



/*
//https://dalgonakit.tistory.com/109
  void _showDialog() {
    TextEditingController inputController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
          title: const Text("알림 시간 설정"),
          content:  TextField(
            controller: inputController,

            decoration: const InputDecoration(
              hintText: '알림',
            ),


            keyboardType: TextInputType.datetime,

            ),

          actions: <Widget>[
            FlatButton(
              child: const Text("확인"),
              onPressed: () {
                inputText = inputController.text;

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
*/
}

