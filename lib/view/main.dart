import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/services/note_service.dart';
import 'package:rest_api/view/note_list.dart';

void setUpLocator() {
  GetIt.I.registerLazySingleton(() => NoteServices());
}

void main() {
  setUpLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: NoteList(),
    );
  }
}
