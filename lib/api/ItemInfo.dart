// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';





class ItemOutput{
  ItemOutput({
     required this.name,
     required this.num
});

String name;
String num;

Map<String, dynamic> toJson() => {
  'name': name,
  'num': num,
};


}

class Item {
  Item({
    required this.name,
    required this.pricechart,
    required this.result,
  });

  String name;
  List<Pricechart> pricechart;
  String result;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["Name"],
    pricechart: List<Pricechart>.from(json["Pricechart"].map((x) => Pricechart.fromJson(x))),
    result: json["Result"],
  );


}

class Pricechart {
  Pricechart({
    required this.amount,
    required this.price,
  });

  String amount;
  String price;

  factory Pricechart.fromJson(Map<String, dynamic> json) => Pricechart(
    amount: json["Amount"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "Amount": amount,
    "Price": price,
  };
}
