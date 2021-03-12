import 'package:flutter/material.dart';
import 'package:rest_api/view/note_list.dart';

void main() => runApp(App());

class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: NoteList(),
    );

  }

}



