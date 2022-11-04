class Calendar{

//월화수목금토일 순 매시간
  List<bool> chaosGate = [true, false, false, true, false, true, true] ; //카오스게이트
  List<bool> fieldBoss = [false, true, false, false, true, false, true] ; // 필드 보스
  List<bool> ghostShip = [false, true, false, true, false, true, false] ; //유령선

//로웬 습격전
  //평일(월 수 목) 20:30
  //주말 15:30 22:30 (+토요일=20:30)
  List<bool> lowenRaidBattle = [true, false, true, true, false, true, true];
  List<bool> lowenRvR = [false, false, true, false, false, true, true]; //툴루비크 22:00 (수 토 일)
  List<bool> occupationEvent = [false,false,false,false,false,true, true]; //점령전 22:30 (토 일)

  //각 요일에 번호를 할당
  var dayOfWeek = [
    'Mon', //0
    'Tue', //1
    'Wed', //2
    'Thu', //3
    'Fri', //4
    'Sat', //5
    'Sun', //6
  ];

  Map dayOfWeekMap = {};

  int convertDayOfWeek(String day){
    dayOfWeekMap[dayOfWeek[0]] = 0; //Mon
    dayOfWeekMap[dayOfWeek[1]] = 1; //Tue
    dayOfWeekMap[dayOfWeek[2]] = 2; //Wed
    dayOfWeekMap[dayOfWeek[3]] = 3; //Thu
    dayOfWeekMap[dayOfWeek[4]] = 4; //Fri
    dayOfWeekMap[dayOfWeek[5]] = 5; //Sat
    dayOfWeekMap[dayOfWeek[6]] = 6; //Sun

    return dayOfWeekMap[day];
  }
}




