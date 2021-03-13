import 'package:flutter/foundation.dart';

class NoteModel {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  String noteContent;

  NoteModel({this.noteID,
    @required this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
    @required this.noteContent});

  factory NoteModel.fromJson(Map<String, dynamic> item) {
    return NoteModel(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        createDateTime: DateTime.parse(item['createDateTime']),
        latestEditDateTime: item['latestEditDateTime'] != null
            ? DateTime.parse(item['latestEditDateTime'])
            : null,
        noteContent: item['noteContent'] ?? ''
    );
  }

 static Map<String, dynamic> toJson(NoteModel item) {
    var details = new Map<String, dynamic>();
    details["noteTitle"] = item.noteTitle;
    details['noteContent'] = item.noteContent;
    return details;
  }



}
