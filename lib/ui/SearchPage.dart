import 'package:flutter/material.dart';

//https://flutter-ko.dev/docs/cookbook/forms/validation
//https://dev-yakuza.posstree.com/ko/flutter/widget/textfield/#textfield

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
//  final _formKey = GlobalKey<FormState>();
  String inputText = '';
  TextEditingController inputController = TextEditingController();

  void _incrementCounter() {
    setState(() {

    });

  }

  void inputDataPost(){

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Text('$inputText'),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),

                  child: TextField(
                    controller: inputController,
                  //  onChanged: (text) {
                  //    setState(() {
                  //      inputText = text;
                  //    });
                  //    },

                    decoration: InputDecoration(
                      hintText: '아이템명',
                      labelStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        borderSide:
                        BorderSide(width: 1, color: Colors.redAccent),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        borderSide:
                        BorderSide(width: 1, color: Colors.redAccent),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  //데이터 가져옴
                  inputText = inputController.text;
                });
              },
              child: Text('검색'),
            ),
              ],


        ),

      ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}