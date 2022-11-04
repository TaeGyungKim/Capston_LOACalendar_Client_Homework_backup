
//     final island = islandFromJson(jsonString);
//String islandToJson(Island data) => json.encode(data.toJson());

class Island {
  Island({
    required this.island,
    required this.islandDate,
  });

  List<IslandElement> island;
  String islandDate;

  factory Island.fromJson(Map<String, dynamic> json) {
    return Island(
      island: List<IslandElement>.from(
          json['Island'].map((x) =>
              IslandElement.fromJson(x))),

      islandDate: json['IslandDate'],
    );
  }
}

class IslandElement {
  IslandElement({
    required this.name,
    required this.reward,
  });

  String name;
  String reward;

  factory IslandElement.fromJson(Map<String, dynamic> json) => IslandElement(
    name: json['Name'],
    reward: json['Reward'],
  );
}