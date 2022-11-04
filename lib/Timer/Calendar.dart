import 'package:intl/intl.dart';

import '../data/CalendarData.dart';
import 'Time.dart';

//모험섬 시작시간 - 현재시간
//이때 Millisecond로 환산 후 계산
Duration remainedIslandTimer(String islandTime){
  //DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  //모험섬 시작 시간
  DateTime dateStartTime = DateTime.parse(islandTime);
  int timeMilliSeconds = dateStartTime.millisecondsSinceEpoch;

  int remainMilliSeconds = timeMilliSeconds - currentMilliSeconds - koreaUTC ;

  //0분 0초 이하면 0분 0초로 고정
  if (remainMilliSeconds<= -koreaUTC) {timeMilliSeconds= -koreaUTC;}

  DateTime date = DateTime.fromMillisecondsSinceEpoch(remainMilliSeconds);
  final  dateDuration=  Duration(
      days:date.day-1,
      hours: date.hour,
      minutes: date.minute,
      seconds: date.second,
      milliseconds: 0 ,
      microseconds: 0 );

  return dateDuration;
  //DateFormat remainFormatter = DateFormat('시작까지 남은 시간: MM월 dd일 HH시 mm분 ss초 ');
  //String strRemain = remainFormatter.format(date);
}

class CalendarTimer {

  List<bool> calendarContent = [false, false, false, false, false, false];


  int todayConvertInt() {
    DateFormat formatter = DateFormat('E');
    String todayString = formatter.format(now);

    int todayInt = Calendar().convertDayOfWeek(todayString); //오늘의 요일을 int값으로 반환

    return todayInt;
  }

//Duration으로 바꿔야함
//정각 기준으로 캘린더 변경
  List<bool> isTodayCalendar() {
    int todayInt = todayConvertInt();
    //
    //타이머 활성화 여부
    calendarContent = [
      Calendar().chaosGate[todayInt],
      Calendar().fieldBoss[todayInt],
      Calendar().ghostShip[todayInt],
      Calendar().lowenRaidBattle[todayInt],
      Calendar().lowenRvR[todayInt],
      Calendar().occupationEvent[todayInt],
    ];

    return calendarContent;
  }


//매시간 타이머 활성화 (카오스게이트)
  Duration chaosGateTimer(List<bool> calendarContent) {
    Duration remainedDuration;

    if (!calendarContent[0]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    final startDuration = Duration(
        hours: now.hour + 1,
        minutes: 0,
        seconds: 0
    );

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    remainedDuration = startDuration - nowDuration;

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }

    return remainedDuration;
  }

//매시간 타이머 활성화 (필드보스)
  Duration fieldBossTimer(List<bool> calendarContent) {
    Duration remainedDuration;

    if (!calendarContent[1]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    final startDuration = Duration(
        hours: now.hour + 1,
        minutes: 0,
        seconds: 0
    );

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    remainedDuration = startDuration - nowDuration;

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }

    return remainedDuration;
  }

//매시간 타이머 활성화 (유령선)
  Duration ghostShipTimer(List<bool> calendarContent) {
    Duration remainedDuration;

    if (!calendarContent[2]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    final startDuration = Duration(
        hours: now.hour + 1,
        minutes: 0,
        seconds: 0
    );

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    remainedDuration = startDuration - nowDuration;

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }

    return remainedDuration;
  }

//로웬 습격전
  Duration lowenRaidBattleTimer(List<bool> calendarContent) {
    Duration remainedDuration;

    if (!calendarContent[3]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    const startWeekday = Duration(hours: 20, minutes: 30,);
    const startWeekend_1 = Duration(hours: 15, minutes: 30,);
    const startWeekend_2 = Duration(hours: 22, minutes: 30,);

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    //15:30 전이고 월 수 목 토
    if (startWeekend_1 - nowDuration > const Duration(seconds: 0) &&
        (todayConvertInt() != 1 || todayConvertInt() != 4 ||
            todayConvertInt() != 6)) {
      remainedDuration = startWeekend_1 - nowDuration;

      //20:30 전이고 토 일
    } else if (startWeekday - nowDuration > const Duration(seconds: 0) &&
        (todayConvertInt() == 5 || todayConvertInt() == 6)) {
      remainedDuration = startWeekday - nowDuration;

      //22시 30분 전이고 토 일
    } else if (startWeekend_2 - nowDuration > const Duration(seconds: 0) &&
        (todayConvertInt() == 5 || todayConvertInt() == 6)) {
      remainedDuration = startWeekend_2 - nowDuration;
    } else {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }
    return remainedDuration;
  }

//수 토 일 22:00 (툴루비크)
  Duration lowenRvRTimer(List<bool> calendarContent) {
    Duration remainedDuration;

    if (!calendarContent[4]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    const startDuration = Duration(
      hours: 22,
      minutes: 00,
    );

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    remainedDuration = startDuration - nowDuration;

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }

    return remainedDuration;
  }


//토, 일 22:30 (점령전 이벤트)
  Duration occupationEventTimer(List<bool> calendarContent) {
    Duration remainedDuration;
    if (!calendarContent[5]) {
      remainedDuration = const Duration(seconds: -1);
      return remainedDuration;
    }

    const startDuration = Duration(
      hours: 22,
      minutes: 30,
    );

    final nowDuration = Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second
    );

    remainedDuration = startDuration - nowDuration;

    if (remainedDuration <= const Duration(seconds: 0)) {
      remainedDuration = const Duration(seconds: 0);
    }

    return remainedDuration;
  }

}